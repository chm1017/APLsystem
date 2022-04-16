package com.cm.APL.workbench.domain;

public class Driver {
           private String did;
           private String dname;
           private String dage;
           private String dphone;
           private String daddress;
           private String dplace;
           private String dpicture;
           private String idNumber;
           private String driveId;
           private String stage;
           private String createBy;

    @Override
    public String toString() {
        return "Driver{" +
                "did='" + did + '\'' +
                ", dname='" + dname + '\'' +
                ", dage='" + dage + '\'' +
                ", dphone='" + dphone + '\'' +
                ", daddress='" + daddress + '\'' +
                ", dplace='" + dplace + '\'' +
                ", dpicture='" + dpicture + '\'' +
                ", idNumber='" + idNumber + '\'' +
                ", driveId='" + driveId + '\'' +
                ", stage='" + stage + '\'' +
                ", createBy='" + createBy + '\'' +
                '}';
    }

    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getDage() {
        return dage;
    }

    public void setDage(String dage) {
        this.dage = dage;
    }

    public String getDphone() {
        return dphone;
    }

    public void setDphone(String dphone) {
        this.dphone = dphone;
    }

    public String getDaddress() {
        return daddress;
    }

    public void setDaddress(String daddress) {
        this.daddress = daddress;
    }

    public String getDplace() {
        return dplace;
    }

    public void setDplace(String dplace) {
        this.dplace = dplace;
    }

    public String getDpicture() {
        return dpicture;
    }

    public void setDpicture(String dpicture) {
        this.dpicture = dpicture;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getDriveId() {
        return driveId;
    }

    public void setDriveId(String driveId) {
        this.driveId = driveId;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
}
