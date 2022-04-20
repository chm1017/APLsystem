package com.cm.APL.workbench.domain;

public class Fproduct {
    private String pid;
    private String pname;
    private String createDate;
    private String endDate;
    private String merchant;
    private Integer repertory;
    private Double price;
    private String paddress;
    private String description;
    private String createBy;

    @Override
    public String toString() {
        return "Fproduct{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", createDate='" + createDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", merchant='" + merchant + '\'' +
                ", repertory=" + repertory +
                ", price=" + price +
                ", paddress='" + paddress + '\'' +
                ", description='" + description + '\'' +
                ", createBy='" + createBy + '\'' +
                '}';
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getMerchant() {
        return merchant;
    }

    public void setMerchant(String merchant) {
        this.merchant = merchant;
    }

    public Integer getRepertory() {
        return repertory;
    }

    public void setRepertory(Integer repertory) {
        this.repertory = repertory;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getPaddress() {
        return paddress;
    }

    public void setPaddress(String paddress) {
        this.paddress = paddress;
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
}
