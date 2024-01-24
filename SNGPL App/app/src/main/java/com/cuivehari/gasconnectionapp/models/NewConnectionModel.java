package com.cuivehari.gasconnectionapp.models;

public class NewConnectionModel {

    String applicant_name;
    String email;
    String phone;
    String cnic;
    String cnic_issue_date;
    String sun_daughter_wife_of;
    String address;
    String province;
    String city;
    String nearest_place;
    String nearest_consumer_no;
    String type_of_premises;
    String area_of_premises;
    String user_auth_id;
    String cnic_front_image_url;
    String cnic_back_image_url;
    String document_image_url;
    boolean is_chalan_generated;
    boolean is_chalan_paid;

    public NewConnectionModel() {
    }

    public NewConnectionModel(String applicant_name, String email, String phone, String cnic, String cnic_issue_date, String sun_daughter_wife_of, String address, String province, String city, String nearest_place, String nearest_consumer_no, String type_of_premises, String area_of_premises, String user_auth_id, String cnic_front_image_url, String cnic_back_image_url, String document_image_url, boolean is_chalan_generated, boolean is_chalan_paid) {
        this.applicant_name = applicant_name;
        this.email = email;
        this.phone = phone;
        this.cnic = cnic;
        this.cnic_issue_date = cnic_issue_date;
        this.sun_daughter_wife_of = sun_daughter_wife_of;
        this.address = address;
        this.province = province;
        this.city = city;
        this.nearest_place = nearest_place;
        this.nearest_consumer_no = nearest_consumer_no;
        this.type_of_premises = type_of_premises;
        this.area_of_premises = area_of_premises;
        this.user_auth_id = user_auth_id;
        this.cnic_front_image_url = cnic_front_image_url;
        this.cnic_back_image_url = cnic_back_image_url;
        this.document_image_url = document_image_url;
        this.is_chalan_generated = is_chalan_generated;
        this.is_chalan_paid = is_chalan_paid;
    }

    public String getApplicant_name() {
        return applicant_name;
    }

    public void setApplicant_name(String applicant_name) {
        this.applicant_name = applicant_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCnic() {
        return cnic;
    }

    public void setCnic(String cnic) {
        this.cnic = cnic;
    }

    public String getCnic_issue_date() {
        return cnic_issue_date;
    }

    public void setCnic_issue_date(String cnic_issue_date) {
        this.cnic_issue_date = cnic_issue_date;
    }

    public String getSun_daughter_wife_of() {
        return sun_daughter_wife_of;
    }

    public void setSun_daughter_wife_of(String sun_daughter_wife_of) {
        this.sun_daughter_wife_of = sun_daughter_wife_of;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getNearest_place() {
        return nearest_place;
    }

    public void setNearest_place(String nearest_place) {
        this.nearest_place = nearest_place;
    }

    public String getNearest_consumer_no() {
        return nearest_consumer_no;
    }

    public void setNearest_consumer_no(String nearest_consumer_no) {
        this.nearest_consumer_no = nearest_consumer_no;
    }

    public String getType_of_premises() {
        return type_of_premises;
    }

    public void setType_of_premises(String type_of_premises) {
        this.type_of_premises = type_of_premises;
    }

    public String getArea_of_premises() {
        return area_of_premises;
    }

    public void setArea_of_premises(String area_of_premises) {
        this.area_of_premises = area_of_premises;
    }

    public String getCnic_front_image_url() {
        return cnic_front_image_url;
    }

    public String getUser_auth_id() {
        return user_auth_id;
    }

    public void setUser_auth_id(String user_auth_id) {
        this.user_auth_id = user_auth_id;
    }

    public void setCnic_front_image_url(String cnic_front_image_url) {
        this.cnic_front_image_url = cnic_front_image_url;
    }

    public String getCnic_back_image_url() {
        return cnic_back_image_url;
    }

    public void setCnic_back_image_url(String cnic_back_image_url) {
        this.cnic_back_image_url = cnic_back_image_url;
    }

    public String getDocument_image_url() {
        return document_image_url;
    }

    public void setDocument_image_url(String document_image_url) {
        this.document_image_url = document_image_url;
    }

    public boolean isIs_chalan_generated() {
        return is_chalan_generated;
    }

    public void setIs_chalan_generated(boolean is_chalan_generated) {
        this.is_chalan_generated = is_chalan_generated;
    }

    public boolean isIs_chalan_paid() {
        return is_chalan_paid;
    }

    public void setIs_chalan_paid(boolean is_chalan_paid) {
        this.is_chalan_paid = is_chalan_paid;
    }
}

