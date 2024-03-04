// ignore_for_file: file_names

class HospitalTreatmentModel {
  late String doctorName;
  late String patientName;
  late String disease;
  late String hospitalId;
  late String treatmentDate;

  HospitalTreatmentModel(this.doctorName, this.patientName, this.disease,
      this.hospitalId, this.treatmentDate);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'PatientID': patientName,
        'DoctorName': doctorName,
        'Disease': disease,
        'HospitalID': hospitalId,
        'DateOfAppointment': treatmentDate
      };

  factory HospitalTreatmentModel.fromJson(Map<String, dynamic> v) {
    return HospitalTreatmentModel(
      v['PatientID'],
      v['DoctorName'],
      v['Disease'],
      v['HospitalID'],
      v['DateOfAppointment'],
    );
  }
}