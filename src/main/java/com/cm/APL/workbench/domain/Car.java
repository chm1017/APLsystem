package com.cm.APL.workbench.domain;




public class Car {
            private String cid;
            private String plateNo;
            private String cplace;
            private String stage;
            private String company;
            private String did;
            private String cload;
            private String fdjId;//发动机id
            private String baoxianId;
            private String description;
            private String cname;
            private String createBy;

    @Override
    public String toString() {
        return "Car{" +
                "cid='" + cid + '\'' +
                ", plateNo='" + plateNo + '\'' +
                ", cplace='" + cplace + '\'' +
                ", stage='" + stage + '\'' +
                ", company='" + company + '\'' +
                ", did='" + did + '\'' +
                ", cload='" + cload + '\'' +
                ", fdjId='" + fdjId + '\'' +
                ", baoxianId='" + baoxianId + '\'' +
                ", description='" + description + '\'' +
                ", cname='" + cname + '\'' +
                ", createBy='" + createBy + '\'' +
                '}';
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getPlateNo() {
        return plateNo;
    }

    public void setPlateNo(String plateNo) {
        this.plateNo = plateNo;
    }

    public String getCplace() {
        return cplace;
    }

    public void setCplace(String cplace) {
        this.cplace = cplace;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    public String getCload() {
        return cload;
    }

    public void setCload(String cload) {
        this.cload = cload;
    }

    public String getFdjId() {
        return fdjId;
    }

    public void setFdjId(String fdjId) {
        this.fdjId = fdjId;
    }

    public String getBaoxianId() {
        return baoxianId;
    }

    public void setBaoxianId(String baoxianId) {
        this.baoxianId = baoxianId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
}
