package xin.liaozhixing.model.base;

import java.util.List;

public class BaseTableResponse {

    // 状态码 0 成功 失败 其他
    private Integer code;
    // 错误提示
    private String msg;
    // 总数
    private Integer count;
    // 实体集合
    private List data;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
