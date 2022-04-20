package com.cm.APL.workbench.domain;




public class Orderform {
            private String id;
            private String name;
            private Double totalprice;
            private String createDate;
            private String createBy;;
            private String carid;
            private String description;
            private String stage;

    @Override
    public String toString() {
        return "Orderform{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", totalprice=" + totalprice +
                ", createDate='" + createDate + '\'' +
                ", createBy='" + createBy + '\'' +
                ", carid='" + carid + '\'' +
                ", description='" + description + '\'' +
                ", stage='" + stage + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(Double totalprice) {
        this.totalprice = totalprice;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCarid() {
        return carid;
    }

    public void setCarid(String carid) {
        this.carid = carid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }
}
