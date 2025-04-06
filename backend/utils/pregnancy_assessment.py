
def assess_pregnancy_risk(data):
    # Placeholder rule-based logic
    age = data.get('age')
    hemoglobin = data.get('hemoglobin')
    risk = []
    if age < 18 or age > 35:
        risk.append("Age-related risk")
    if hemoglobin and hemoglobin < 11:
        risk.append("Possible anemia")
    return {'risk_factors': risk, 'is_high_risk': len(risk) > 0}
