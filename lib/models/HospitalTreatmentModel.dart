// ignore_for_file: file_names

class HospitalTreatmentModel {
  late String doctorName;
  late String patientName;
  late String disease;
  late String hospitalId;
  late String appointmentId;
  late String treatmentDate;
  late String status;

  HospitalTreatmentModel(this.doctorName, this.patientName, this.disease,
      this.hospitalId, this.appointmentId, this.treatmentDate, this.status);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'PatientID': patientName,
        'DoctorName': doctorName,
        'Disease': disease,
        'HospitalID': hospitalId,
        'AppointmentID': appointmentId,
        'DateOfAppointment': treatmentDate,
        'Status': status,
      };

  factory HospitalTreatmentModel.fromJson(Map<String, dynamic> v) {
    return HospitalTreatmentModel(
      v['PatientID'],
      v['DoctorName'],
      v['Disease'],
      v['HospitalID'],
      v['AppointmentID'],
      v['DateOfAppointment'],
      v['Status'],
    );
  }
}
