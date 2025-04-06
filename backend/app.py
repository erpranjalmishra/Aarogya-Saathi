
from flask import Flask, request, jsonify
from utils.pregnancy_assessment import assess_pregnancy_risk
from utils.scheme_info import get_scheme_info

app = Flask(__name__)

@app.route('/')
def home():
    return "Aarogya Saathi Backend API Running"

@app.route('/risk-assessment', methods=['POST'])
def risk_assessment():
    data = request.json
    result = assess_pregnancy_risk(data)
    return jsonify(result)

@app.route('/schemes', methods=['GET'])
def schemes():
    return jsonify(get_scheme_info())

if __name__ == '__main__':
    app.run(debug=True)
