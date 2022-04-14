package com.cm.APL.workbench.domain;


public class Merchant {
            private String mid ;
            private String mname;
            private String mage ;
            private String maddress;
            private String memail;
            private String mphone;
            private String description;
            private String createBy;
            private String createDate;
            private String editBy;
            private String editDate;
            private String company;

    @Override
    public String toString() {
        return "Merchant{" +
                "mid='" + mid + '\'' +
                ", mname='" + mname + '\'' +
                ", mage='" + mage + '\'' +
                ", maddress='" + maddress + '\'' +
                ", memail='" + memail + '\'' +
                ", mphone='" + mphone + '\'' +
                ", description='" + description + '\'' +
                ", createBy='" + createBy + '\'' +
                ", createDate='" + createDate + '\'' +
                ", editBy='" + editBy + '\'' +
                ", editDate='" + editDate + '\'' +
                ", company='" + company + '\'' +
                '}';
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getMage() {
        return mage;
    }

    public void setMage(String mage) {
        this.mage = mage;
    }

    public String getMaddress() {
        return maddress;
    }

    public void setMaddress(String maddress) {
        this.maddress = maddress;
    }

    public String getMemail() {
        return memail;
    }

    public void setMemail(String memail) {
        this.memail = memail;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getEditDate() {
        return editDate;
    }

    public void setEditDate(String editDate) {
        this.editDate = editDate;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }
}
