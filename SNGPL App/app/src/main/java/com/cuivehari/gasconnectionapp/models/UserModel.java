package com.cuivehari.gasconnectionapp.models;

import java.util.List;

public class UserModel {

    String user_name;
    String email;
    String phone;
    String cnic;
    String cnic_issue_date;
    String password;
    String user_auth_id;

    public UserModel() {
    }

    public UserModel(String user_name, String email, String phone, String cnic, String cnic_issue_date, String password, String user_auth_id) {
        this.user_name = user_name;
        this.email = email;
        this.phone = phone;
        this.cnic = cnic;
        this.cnic_issue_date = cnic_issue_date;
        this.password = password;
        this.user_auth_id = user_auth_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUser_auth_id() {
        return user_auth_id;
    }

    public void setUser_auth_id(String user_auth_id) {
        this.user_auth_id = user_auth_id;
    }
}

