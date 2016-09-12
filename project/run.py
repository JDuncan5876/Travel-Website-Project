
from collections import namedtuple
from flask import Flask, request, render_template, session, redirect, url_for, flash, redirect
import pymysql
import datetime


app = Flask(__name__)
app.secret_key = 'keep_it_low'

@app.route('/', methods=["GET","POST"])
def index():
	if request.method == 'POST':	
		email1 = request.form['username'] 
		pass1 = request.form['password']
		cursor = db.cursor()
		cursor.execute("select * from user where email = '" + email1 + "' and password = '" + pass1 + "' and is_admin = '1' and is_suspended = '0';")
		adminrows = cursor.fetchall()
		
		if adminrows:
			session['email'] = email1
			return redirect(url_for('admin')) 
		
		else:
			cursor.execute("select * from user where is_suspended = '0' and email = '" + email1 + "' and password = '" + pass1 + "';")		
			rows = cursor.fetchall()
			session['email'] = email1
			
			if rows:
				return redirect(url_for('user')) 
			
			else: 
				flash("Login Invalid. Try Again")				
	return render_template("login.html")



@app.route('/register', methods=["GET","POST"])
def registration():
	if request.method == 'POST': 
		First_name = (request.form['Fname'])
		Last_name = (request.form['Lname'])
		Email = (request.form['email'])	
		Password = (request.form['password'])
		Address = (request.form['address'])
		Address2 = (request.form['address2'])

		if Address2 == '':
			Address2 = 'NULL'

		City = (request.form['city'])
		Zipcode = (request.form['zipcode'])
		Country = (request.form['country'])

		cursor = db.cursor()
		cursor.execute("insert into user values ('" + Email + "', '" + Password + "', '" + First_name + "', '" + Last_name + "', false, false, '" + Address + "', '" + Address2 + "', '" + City + "', '" + Zipcode + "', '" + Country + "');")
		db.commit()
	return render_template("register.html")

@app.route('/user')
def user():
	email = session['email']
	cursor = db.cursor()
	cursor.execute("select first_name from user where email = '" + email + "';")
	name = cursor.fetchall()
	first = name[0]
	first_name = str(first)
	f = first_name [2:]
	fn = f [:-3]
	return render_template('home.html', name = fn)

@app.route('/admin', methods = ["GET","POST"])
def admin():
	email = session['email']
	cursor = db.cursor()
	cursor.execute("select first_name from user where email = '" + email + "';")
	name = cursor.fetchall()
	first = name[0]
	first_name = str(first)
	f = first_name [2:]
	fn = f [:-3]

	user_list = []

	cursor = db.cursor()
	cursor.execute("select first_name, last_name, email from user;")
	user_rows = cursor.fetchall()

	for row in user_rows:
		user_list.append(row)
	
	if request.method == 'POST':
		Title = (request.form['title'])	
		Address = (request.form['address'])
		Address2 = (request.form['address2'])
		City = (request.form['city'])
		Zipcode = (request.form['zip'])
		Country = (request.form['country'])
		Description = (request.form['description'])
		Price = (request.form['price'])
		Reservation = (request.form['reservation'])

		if Reservation == 'Yes':
			Reservation = '1'

		else:
			Reservation = '0'

		Capacity = (request.form['capacity'])
		Public = (request.form['pub_trans'])
		Public_Address = (request.form['pub_address'])
		Public_Address2 = (request.form['pub_address2'])
		Days = (request.form['days'])
		Day_list = Days.split(',')
		Open = (request.form['open'])
		Open = str(Open) + ':00'
		Close = (request.form['close'])
		Close = str(Close) + ':00'
		cursor = db.cursor()

		cursor.execute("Insert into public_trans values ('" + Public + "', '" + Public_Address + "', '" + Public_Address2 + "', '" + City + "');")
		db.commit()
		cursor = db.cursor()
		cursor.execute("Insert into attraction values ('" + Title + "', '" + Address + "', '" + Address2 + "', '" + City + "', '" + Zipcode + "', '" + Country + "', '" + Description + "', '" + Price + "', '" + Reservation + "', '" + Capacity + "', '" + Public + "');")  
		db.commit()

		for day in Day_list:
			cursor = db.cursor()
			cursor.execute("Insert into open_times values ('" + Title + "', '" + day + "', '" + Open + "', '" + Close + "');")
			db.commit()

	
	cursor = db.cursor()
	cursor.execute("select attraction.name, attraction.city, attraction.capacity from attraction;")
	attraction_list = cursor.fetchall()

	

	
		



	return render_template("admin.html",userrows = user_list, attractions= attraction_list, name = fn)

@app.route('/delete-user/<username>', methods = ["GET","POST"])
def delete(username):
	cursor = db.cursor()
	cursor.execute("delete from user where email = '" + username + "';")
	db.commit()
	return ("The user has been deleted")

@app.route('/suspend-user/<username>', methods = ["GET","POST"])
def suspend(username):
	cursor = db.cursor()
	cursor.execute("Update user Set is_suspended = '1' where email = '" + username + "';")
	db.commit()
	return ("The user has been suspended")

@app.route('/unsuspend-user/<username>', methods = ["GET","POST"])
def unsuspend(username):
	cursor = db.cursor()
	cursor.execute("Update user Set is_suspended = '0' where email = '" + username + "';")
	db.commit()
	return ("The user has been unsuspended")

@app.route('/admin-user/<username>', methods = ["GET","POST"])
def adminuser(username):
	cursor = db.cursor()
	cursor.execute("Update user Set is_admin = '1' where email = '" + username + "';")
	db.commit()
	return ("The user is now an admin")

@app.route('/unbook/<trip_id>', methods = ["GET", "POST"])
def unbook(trip_id):

	cursor = db.cursor()
	cursor.execute("select reservation_id from activity where trip_id = '" + trip_id + "';")
	x = cursor.fetchall() [0]
	xx = str(x)
	xxx = xx[1:]
	xxxx = xxx [:-2]
	cursor.execute("delete from reservation where reservation_id = '" + xxxx + "';")
	cursor.execute("delete from trip where trip_id = '" + trip_id + "'; ") 
	db.commit()

	return("The Trip has been Unbooked!")

@app.route('/trip', methods = ["GET","POST"])
def mytrip():
	attraction_list = []
	cursor = db.cursor()
	cursor.execute("select attraction.name, attraction.city, attraction.country, attraction.description, attraction.price, attraction.requires_reservation, attraction.capacity, attraction.nearest_public_trans from attraction;")
	attraction_rows = cursor.fetchall()
	for row in attraction_rows:
		attraction_list.append(row)

	if request.method == 'POST':
		print ("it posted")
		index = 0
		checked = request.form.getlist('activity')
		party_list = []
		date_list = []
		for x in range(1,10):
				p = request.form["party_" + str(x)]
				if p != '':
					party_list.append(p)
				d = request.form["date_" + str(x)]
				if d != '':
					date_list.append(d)
	
		for activity in checked:
			attraction = activity
			email = session['email']
			Start_Date = date_list[index]
			End_Date = Start_Date
			cursor = db.cursor()
			cursor.execute("Select cc_number from credit_card where credit_card.email = '" + email + "' limit 1")
			number = cursor.fetchall()[0]
			ccc = str(number)
			cc = ccc[2:]
			credit_number = cc[:-3]
			Party = party_list[index]
			cursor = db.cursor()
			cursor.execute ("Select requires_reservation from attraction where attraction.name = '" + attraction + "';")
			x = cursor.fetchall()[0]
			xx = str(x)
			requires_reservation = xx[1]
			cursor = db.cursor()
			cursor.execute("Select price from attraction where attraction.name = '" + attraction + "';")
			q = cursor.fetchall() [0]
			qq = str(q)
			qqq = qq[10:]
			price = qqq[:-4]
			total_ = float(price) * int(Party)
			total_cost = str(total_)
			if index == 0:
				cursor = db.cursor()
				cursor.execute("Select city from attraction where attraction.name = '" + attraction + "';")
				city1 = cursor.fetchall()[0]
				c = str(city1)
				cc = c[2:]
				city = cc[:-3]
				
				cursor = db.cursor()
				cursor.execute("Insert into trip (trip_user, city, booked, cc_number) Values ('" + email + "', '" + city + "', '1', '" + credit_number + "');")
				db.commit()

				cursor = db.cursor()
				cursor.execute("Select trip_id from trip order by trip_id desc limit 1;")
				t = cursor.fetchall()[0]
				
				tt = str(t)
				ttt = tt [1:]
				trip_id = ttt[:-2]
				
			
			if requires_reservation == '1':
				cursor = db.cursor()
				cursor.execute("Insert into reservation (city, start_date_time, end_date_time, total_cost, number_in_party) Values ('" + city + "', '" + Start_Date + "', '" + End_Date + "', '" + total_cost + "', '" + Party + "');")
				db.commit()

				cursor = db.cursor()
				cursor.execute("Select reservation_id from reservation order by reservation_id desc limit 1;")
				i = cursor.fetchall() [0]
				
				ii = str(i)
				rres_id = ii[1:]
				res_id = rres_id[:-2]
				cursor = db.cursor()
				cursor.execute("Insert into activity (attraction_name, start_date_time, end_date_time, trip_id, reservation_id) Values ('" + attraction + "', '" + Start_Date + "', '" + End_Date + "', '" + trip_id + "', '" + res_id + "');")
				db.commit()

			else:
				

				cursor = db.cursor()
				cursor.execute("Insert into activity (attraction_name, start_date_time, end_date_time, trip_id) Values ('" + attraction + "', '" + Start_Date + "', '" + End_Date + "', '" + trip_id + "');")
				db.commit()
			
			index += 1




	return render_template('trip.html', attractions = attraction_rows)

@app.route('/mytrip', methods = ["GET","POST"])
def confirm():
	cursor = db.cursor()
	email = session['email']
	cursor.execute("Select trip_id, city from trip where trip_user = '" + email + "';")
	trip_list = cursor.fetchall()


	
	return render_template('confirm.html', trip_list = trip_list)
		
@app.route('/credit', methods =["GET","POST"])
def credit():
	if request.method == 'POST':
		First_name = (request.form['Fname'])
		Last_name = (request.form['Lname'])
		Email = (request.form['email'])	
		Card = (request.form['cardnum'])
		Security = (request.form['securitynum'])
		Expiration = (request.form["expirydate"])
		Address = (request.form['address'])
		Address2 = (request.form['address2'])
		City = (request.form['city'])
		Zipcode = (request.form['zipcode'])
		Country = (request.form['country'])
		
		cursor = db.cursor()
		cursor.execute("insert into credit_card values ('" + Card + "', '" + First_name + "', '" + Last_name + "', '" + Address + "', '" + Address2 + "', '" + City + "', '" + Zipcode + "', '" + Country + "', '" + Email + "', '" + Expiration + "');")
		db.commit()
	return render_template('credit.html')

@app.route('/review', methods=["GET","POST"])
def review():
	date = datetime.datetime.now()
	dates = str(date)
	dates = dates[0:19]
	attractions = []

	cursor = db.cursor()
	cursor.execute ("select activity.attraction_name from trip join user on user.email = trip.trip_user join activity using (trip_id) where user.email = '" + session['email'] + "';")
	attraction_rows = cursor.fetchall()
	
	for row in attraction_rows:
		row = str(row)
		rows = row[2:]
		rows = rows[:-3]
		attractions.append(rows)
	
	if request.method == 'POST':
		attraction = (request.form['attraction'])
		review = (request.form['review'])
		title = (request.form['title'])	
		email = session['email']

		cursor = db.cursor()
		cursor.execute("insert into review (attraction,email,date_reviewed,body,title) values ('" + attraction + "','" + email + "','" + dates + "','" + review + "','" + title + "');")
		db.commit()
	return render_template("review.html", attractions = attractions)

@app.route('/reviews', methods = ["GET", "POST"])
def read_review():
	review_list = []
	cursor = db.cursor()
	cursor.execute("select attraction, title, body, email from review;")
	reviews = cursor.fetchall()
	
	for review in reviews:
		review_list.append(review)

	return render_template("reviews.html", reviews = review_list)

if __name__ == '__main__':
    dbname = 'team6'
    db = pymysql.connect(host='localhost',
                         user='root', passwd='', db=dbname)   

app.run(debug=True)