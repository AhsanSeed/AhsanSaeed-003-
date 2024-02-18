from flask import Flask, request, jsonify, abort
from flask.templating import render_template
from model import predict
from features import features_list, feature_form_structure

app = Flask(__name__)


@app.route('/')
def hello_world():
    i = 0
    return render_template('index.html', feature_form_structure=feature_form_structure, i=i)


@app.route('/predict', methods=['POST'])
def create_task():
    if not request.json:
        abort(400)
    prediction = predict(request.json)
    return jsonify({'done': True, 'prediction': prediction[0]}), 201


if __name__ == '__main__':
    app.run(debug=True)
