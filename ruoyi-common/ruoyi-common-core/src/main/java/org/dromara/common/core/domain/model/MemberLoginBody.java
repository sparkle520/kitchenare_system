package org.dromara.common.core.domain.model;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;
/**
 * @Author sparkle520
 * @Description 用户登录
 **/
@Data
public class MemberLoginBody implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 手机号
     */
    @NotBlank(message = "手机号不能为空")
    private String phone;

    /**
     * 登录密码
     */
    @NotBlank(message = "密码不能为空")
    private String password;

    /**
     * 验证码
     */
    private String code;
}
