from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/buy', methods=['POST'])
def buy():
    if request.method == 'POST':
        # Get form data
        name = request.form['name']
        email = request.form['email']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zip_code = request.form['zip_code']
        phone = request.form['phone']
        property_type = request.form['property_type']
        budget = request.form['budget']

        # Process the data (e.g., save to a database)
        # For simplicity, let's just print the data
        print(f"Name: {name}")
        print(f"Email: {email}")
        print(f"Address: {address}")
        print(f"City: {city}")
        print(f"State: {state}")
        print(f"Zip Code: {zip_code}")
        print(f"Phone: {phone}")
        print(f"Property Type: {property_type}")
        print(f"Budget: {budget}")

        # Return a success message
        return "Thank you! Your request has been submitted."

if __name__ == '__main__':
    app.run(debug=True)
