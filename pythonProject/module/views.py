from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Sample data structure to store user details
users = []

# Route to display the form to add a new user
@app.route('/')
def index():
    return render_template('index.html')

# Route to handle form submission and add a new user
@app.route('/add_user', methods=['POST'])
def add_user():
    name = request.form['name']
    email = request.form['email']
    users.append({'name': name, 'email': email})
    return redirect(url_for('index'))

# Route to display user details
@app.route('/users')
def show_users():
    return render_template('users.html', users=users)

if __name__ == '__main__':
    app.run(debug=True)

