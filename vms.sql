/*
 Navicat Premium Data Transfer

 Source Server         : localhost_mysql
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : vms

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 21/02/2021 16:26:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_article
-- ----------------------------
DROP TABLE IF EXISTS `app_article`;
CREATE TABLE `app_article`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首图',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_article
-- ----------------------------
INSERT INTO `app_article` VALUES (1, '程序猿', '是时候解放一下广大程序员的双手了', '![](https://blog.52itstyle.vip/usr/uploads/2020/05/1080453092.jpg)\n\n\n## 前言\n\n作为靠双手吃饭的广大程序猿媛们，大家基本都是从数据库的增删改查一步一步过来的，每天都有写不完的代码，好不容易写完了，又会因为改了需求，为了能完工不得不加班写这些简单并且耗时的代码。\n\n那么问题来了，我们可不可以去掉这些繁琐的步骤，把时间更多的放在提升自己的能力上，而不是每天只是做些简单重复繁琐的工作。\n\n## 推荐\n\n今天撸主给大家推荐一款神器`Spring Data REST`，基于`Spring Data`的`Repository`之上，可以把 `Repository` 自动输出为`REST`资源，目前支持`Spring Data JPA、Spring Data MongoDB、Spring Data Neo4j、Spring Data GemFire、Spring Data Cassandra`的 `repository` 自动转换成`REST`服务。\n\n## 案例\n\n#### 开发环境\n\n- Maven\n- JDK1.8\n- SpringBoot 2.2.6\n- spring-boot-starter-data-jpa\n- spring-boot-starter-data-rest\n\n为了测试方便，这里我们使用`h2`内存数据库`lombok`插件，pom.xml引入：\n\n```\n<dependency>\n    <groupId>org.springframework.boot</groupId>\n    <artifactId>spring-boot-starter-data-jpa</artifactId>\n</dependency>\n<dependency>\n    <groupId>org.springframework.boot</groupId>\n    <artifactId>spring-boot-starter-data-rest</artifactId>\n</dependency>\n<dependency>\n    <groupId>com.h2database</groupId>\n    <artifactId>h2</artifactId>\n    <scope>runtime</scope>\n</dependency>\n<dependency>\n    <groupId>org.projectlombok</groupId>\n    <artifactId>lombok</artifactId>\n    <optional>true</optional>\n</dependency>\n```\n\n\n`application.properties` 配置文件：\n\n```\n# 定制根路径\nspring.data.rest.base-path= /api\nspring.application.name=restful\n# 应用服务web访问端口\nserver.port=8080\n```\n\n定义用户实体类：\n```\n/**\n * 实体类\n * https://blog.52itstyle.vip\n */\n@Data\n@Entity\npublic class User {\n    /**\n     * 用户id\n     */\n    @Id\n    @GeneratedValue(strategy = GenerationType.IDENTITY)\n    @Column(name = \"user_id\", nullable = false, length = 20)\n    private Long userId;\n\n    /**\n     * 用户名\n     */\n    @Column(name = \"username\", nullable = false, length = 50)\n    private String username;\n\n    /**\n     * 密码\n     */\n    @Column(name = \"password\", nullable = false, length = 50)\n    private String password;\n\n    /**\n     * 姓名(昵称)\n     */\n    @Column(name = \"nickname\", length = 50)\n    private String nickname;\n\n    /**\n     * 邮箱\n     */\n    @Column(name = \"email\", length = 100)\n    private String email;\n\n    /**\n     * 手机号\n     */\n    @Column(name = \"mobile\", length = 100)\n    private String mobile;\n\n}\n```\n\n定义 `Repository`，不需要写一个接口：\n\n```\n@RepositoryRestResource(collectionResourceRel = \"user\", path = \"user\")\npublic interface UserRepository extends JpaRepository<User, Long> {\n\n}\n```\n\n启动项目，撸主默认初始化了几个用户。启动成功后，访问地址：`http://localhost:8080/api`如果出现以下提示，说明配置成功：\n```\n{\n  \"_links\" : {\n    \"user\" : {\n      \"href\" : \"http://localhost:8080/api/user{?page,size,sort}\",\n      \"templated\" : true\n    },\n    \"profile\" : {\n      \"href\" : \"http://localhost:8080/api/profile\"\n    }\n  }\n}\n```\n\n获取单个用户：\n```\nhttp://localhost:8080/api/user/2\n```\n分页查询：\n```\nhttp://localhost:8080/api/user?page=0&size=10\n```\n\n更多API：\n```\nPOST请求新增用户\nhttp://ip:port/api/user\n\nPUT请求更新id为1的用户\nhttp://ip:port/api/user/1\n\nDELETE请求删除id为1的用户\nhttp://ip:port/api/user/1\n```\n\n如果以上满足不了，我们还可以自定义各种查询：\n\n```\n@RepositoryRestResource(collectionResourceRel = \"user\", path = \"user\")\npublic interface UserRepository extends JpaRepository<User, Long> {\n\n    @RestResource(path = \"nickname\", rel = \"nickname\")\n    List<User> findByNickname(@Param(\"nickname\") String nickname);\n\n}\n```\n查询请求：\n```\nhttp://ip:port/api/user/search/nickname?nickname=张三\n```\n\n## 小结\n\n撸主觉得，这玩意撸一些简单的项目还是完全可以的，如果是复杂的业务逻辑可能吼不住，还需要自己进行进一步的封装处理。\n\n\n## 案例\n\nhttps://gitee.com/52itstyle/restful', NULL, '2020-05-11 21:57:36', '2020-05-11 21:57:36');

-- ----------------------------
-- Table structure for app_email
-- ----------------------------
DROP TABLE IF EXISTS `app_email`;
CREATE TABLE `app_email`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `receive_email` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接收人邮箱',
  `cc_email` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '抄送人邮件',
  `subject` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `template` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(4) NOT NULL COMMENT '发送状态 0 异常 1正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_email
-- ----------------------------
INSERT INTO `app_email` VALUES (1, '345849402@qq.com', '', '11', '11', '', '2020-05-12 21:31:27', 0);

-- ----------------------------
-- Table structure for app_girl
-- ----------------------------
DROP TABLE IF EXISTS `app_girl`;
CREATE TABLE `app_girl`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime NULL DEFAULT NULL,
  `oss_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` smallint(6) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_girl
-- ----------------------------

-- ----------------------------
-- Table structure for app_image
-- ----------------------------
DROP TABLE IF EXISTS `app_image`;
CREATE TABLE `app_image`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `original_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片名称',
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片路径',
  `image_size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片尺寸',
  `porn_status` smallint(6) NOT NULL COMMENT '色情：1  正常 0 色情',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `file_md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件MD5',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_image
-- ----------------------------
INSERT INTO `app_image` VALUES (1, '5ea2b3cc33c5d.jpg', 'file/2020/5/23/984e107ca33740e5a9be1c24f07dd331.jpg', '41KB', 0, '2020-05-23 15:47:05', '458cd91a051128c45908b853055ae33d');
INSERT INTO `app_image` VALUES (2, '5ea2b3cc33c5d.jpg', 'file/2020/5/23/7950f512d91c49f48898913ce86b8867.jpg', '41KB', 0, '2020-05-23 15:48:47', '458cd91a051128c45908b853055ae33d');
INSERT INTO `app_image` VALUES (20, '5ea2b3cc33c5d.jpg', 'file/2020/5/11/55812f4b2b0c436fb7489fab24bc568b.jpg', '41KB', 0, '2020-05-11 22:14:29', '458cd91a051128c45908b853055ae33d');
INSERT INTO `app_image` VALUES (21, '5e15a0992ff73.jpg', 'file/2020/5/12/57d385350b9c44fe8e7b2fff180df85d.jpg', '72KB', 0, '2020-05-12 19:22:01', 'd57f8e82e9eff1a6f8f0f0f16e8fa9a9');
INSERT INTO `app_image` VALUES (22, '5e15a0911d025.jpg', 'file/2020/5/12/9fa78545eb3c4dc28397664af86c1ed4.jpg', '110KB', 0, '2020-05-12 19:22:01', 'c331c246377b66c70371ef399841d2f4');
INSERT INTO `app_image` VALUES (23, '5e15a0950be16.jpg', 'file/2020/5/12/c58b16cf1bb947fd806bb74db5ff1a1a.jpg', '109KB', 0, '2020-05-12 19:22:01', '53f74fb5ec91f620e97c185b6ada4afd');
INSERT INTO `app_image` VALUES (24, '5e15a09407b6f.jpg', 'file/2020/5/12/4de76b3a9103479fba026240841cfea2.jpg', '90KB', 0, '2020-05-12 19:22:02', '72a18c2f0bff09e6550f2629eaec87e7');
INSERT INTO `app_image` VALUES (25, '5e15a093034bd.jpg', 'file/2020/5/12/a92d69bf56e94efaacb2bb07bfc23154.jpg', '110KB', 0, '2020-05-12 19:22:02', '4fa6b94aad20ba974fb09b47fea426f0');
INSERT INTO `app_image` VALUES (26, '5b3206bb88d0b.jpg', 'file/2020/5/12/f8f3b4ae04c348e393b8f1c04dc11be6.jpg', '74KB', 0, '2020-05-12 19:22:47', '0b7c13283e5e3a02d2c49078f1958b20');
INSERT INTO `app_image` VALUES (27, '5b3206ba3831c.jpg', 'file/2020/5/12/193c018d7eda43efa4f81cd2474e8123.jpg', '105KB', 0, '2020-05-12 19:22:47', '1a9fd381c344f24cf4f7376d9edb2484');
INSERT INTO `app_image` VALUES (28, '5b3206bc8cbab.jpg', 'file/2020/5/12/be37030c304643beadc6af663fc64396.jpg', '84KB', 0, '2020-05-12 19:22:47', 'd78aa06e450a226d4c492cb07c86ac6f');
INSERT INTO `app_image` VALUES (29, '5b3206bd93f28.jpg', 'file/2020/5/12/20ea273b015041e498bc22ec5ec90b2b.jpg', '81KB', 0, '2020-05-12 19:22:49', '304b35dfb752cb8b7e92787a68ca339e');
INSERT INTO `app_image` VALUES (30, '5b3206be954bd.jpg', 'file/2020/5/12/377d2be49ee64d71a4bdc3bcc82b75e8.jpg', '89KB', 0, '2020-05-12 19:22:49', 'ed4cdefd18a6efda7a7cdedc333383a3');

-- ----------------------------
-- Table structure for app_notice
-- ----------------------------
DROP TABLE IF EXISTS `app_notice`;
CREATE TABLE `app_notice`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `channel` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通道',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_create` bigint(20) NOT NULL COMMENT '创建人',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '消息通知' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_notice
-- ----------------------------
INSERT INTO `app_notice` VALUES (3, 'SPTools', '21122212121', '2020-05-23 20:06:34', 1, 'admin');
INSERT INTO `app_notice` VALUES (4, 'SPTools', '但是都是多所所多', '2020-05-23 20:07:14', 1, 'admin');
INSERT INTO `app_notice` VALUES (5, 'SPTools', '211221', '2020-05-23 21:32:41', 1, 'admin');
INSERT INTO `app_notice` VALUES (9, 'SPTools', '你几年渠南里吃法你几年渠南里吃法你几年渠南里吃法你几年渠南里吃法', '2020-05-23 21:34:57', 1, 'admin');
INSERT INTO `app_notice` VALUES (10, 'SPTools', '211212', '2020-05-23 21:36:25', 1, 'admin');
INSERT INTO `app_notice` VALUES (11, 'SPTools', '212121', '2020-05-23 21:37:14', 1, 'admin');

-- ----------------------------
-- Table structure for app_push
-- ----------------------------
DROP TABLE IF EXISTS `app_push`;
CREATE TABLE `app_push`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `count` bigint(20) NULL DEFAULT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `recommend_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_push
-- ----------------------------

-- ----------------------------
-- Table structure for app_recommend
-- ----------------------------
DROP TABLE IF EXISTS `app_recommend`;
CREATE TABLE `app_recommend`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `hot` smallint(6) NULL DEFAULT NULL,
  `status` smallint(6) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_create` int(11) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `view` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_recommend
-- ----------------------------
INSERT INTO `app_recommend` VALUES (1, '妹子图', '![](https://bed.52itstyle.com/2020/5/30/zoom_e014b6e4cc5d4e1087b484ee61d0ca0b.jpg)', 'https://bed.52itstyle.com/2020/5/30/zoom_e014b6e4cc5d4e1087b484ee61d0ca0b.jpg', '2020-05-30 13:08:11', 0, 1, '妹子图', NULL, 1, '小柒2012', '467948dd-a1e2-4b8f-b0a1-a6d75f25ec05', 1);

-- ----------------------------
-- Table structure for app_task
-- ----------------------------
DROP TABLE IF EXISTS `app_task`;
CREATE TABLE `app_task`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `task_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `task_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务分组',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务描述',
  `task_class_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行类',
  `method_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行方法',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行时间',
  `trigger_state` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发状态',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务调度' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_task
-- ----------------------------
INSERT INTO `app_task` VALUES (3, 'test01', 'test', '测试任务', 'com.tools.module.app.task.ToolsJob', 'test1', '*/5 * * * * ?', 'PAUSED', '2020-05-23 12:08:49', '2020-05-23 12:08:49');

-- ----------------------------
-- Table structure for app_tiny_url
-- ----------------------------
DROP TABLE IF EXISTS `app_tiny_url`;
CREATE TABLE `app_tiny_url`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `del_status` smallint(6) NOT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `gmt_expire` datetime NULL DEFAULT NULL,
  `hash_key` int(11) NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tiny_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_create` bigint(20) NULL DEFAULT NULL,
  `view` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短链接' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app_tiny_url
-- ----------------------------
INSERT INTO `app_tiny_url` VALUES (1, 1, '2020-05-13 21:34:13', '2020-05-13 21:34:13', -565978978, NULL, 'uINbUr', 0, 'http://www.52itstyle.top/thread-39510-1-1.html', NULL, 0);

-- ----------------------------
-- Table structure for app_wechat
-- ----------------------------
DROP TABLE IF EXISTS `app_wechat`;
CREATE TABLE `app_wechat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatarUrl` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gender` smallint(6) NULL DEFAULT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `openid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `subscribe` smallint(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_wechat
-- ----------------------------
INSERT INTO `app_wechat` VALUES (1, 'https://wx.qlogo.cn/mmopen/vi_32/g97oJaJvf8VbkkebHmZ9L637bUiaXe1e6uI7PFQoX5MHykpXibhoRvxtn5X0WwuXXBL7NCSLPy2217m6VnY4rUrg/132', 'Qingdao', 'China', NULL, 2, '2020-05-31 12:30:10', NULL, 'Shirly', 'undefined', 0);

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence`  (
  `next_val` bigint(20) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES (3);

-- ----------------------------
-- Table structure for mv_advise
-- ----------------------------
DROP TABLE IF EXISTS `mv_advise`;
CREATE TABLE `mv_advise`  (
  `madv_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `madv_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `madv_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `madv_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `madv_to_user_id` int(8) UNSIGNED NOT NULL COMMENT '回复人',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`madv_id`) USING BTREE,
  UNIQUE INDEX `idx_madv_id`(`madv_id`) USING BTREE COMMENT '主键索引',
  INDEX `fk_to_user_id`(`madv_to_user_id`) USING BTREE,
  CONSTRAINT `fk_to_user_id` FOREIGN KEY (`madv_to_user_id`) REFERENCES `mv_user` (`mvus_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '投诉建议' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_advise
-- ----------------------------
INSERT INTO `mv_advise` VALUES (3, '建议多召开群众会议', '建议多召开群众会议', '0', 6, 6, '2018-11-23 01:00:03', 6, '2018-11-23 01:00:03');
INSERT INTO `mv_advise` VALUES (4, '投诉', '投诉', '1', 6, 1, '2018-11-24 10:10:26', 6, '2018-11-24 10:10:52');

-- ----------------------------
-- Table structure for mv_advise_response
-- ----------------------------
DROP TABLE IF EXISTS `mv_advise_response`;
CREATE TABLE `mv_advise_response`  (
  `mvar_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `mvar_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复内容',
  `mvar_advise_id` int(8) UNSIGNED NOT NULL COMMENT '投诉建议ID',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mvar_id`) USING BTREE,
  UNIQUE INDEX `idx_mvar_id`(`mvar_id`) USING BTREE COMMENT '主键索引',
  INDEX `fk_advise_id`(`mvar_advise_id`) USING BTREE,
  CONSTRAINT `fk_advise_id` FOREIGN KEY (`mvar_advise_id`) REFERENCES `mv_advise` (`madv_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '投诉建议回复' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_advise_response
-- ----------------------------
INSERT INTO `mv_advise_response` VALUES (3, '回复建议', 4, 6, '2018-11-24 10:10:52', 6, '2018-11-24 10:10:52');

-- ----------------------------
-- Table structure for mv_article
-- ----------------------------
DROP TABLE IF EXISTS `mv_article`;
CREATE TABLE `mv_article`  (
  `matc_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `matc_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `matc_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `matc_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章分类 01 通知 02 新闻 03 政策 ',
  `matc_organiazation_id` int(8) NOT NULL COMMENT '组织ID',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`matc_id`) USING BTREE,
  UNIQUE INDEX `idx_matc_id`(`matc_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_article
-- ----------------------------
INSERT INTO `mv_article` VALUES (6, '我村获得文明村称号', '热烈祝贺我村获得文明村称号', '01', -1, 1, '2018-11-23 00:22:26', 1, '2018-11-23 00:22:26');
INSERT INTO `mv_article` VALUES (8, '欢迎您登录', '<p>欢迎您登录</p>', '02', 1, 6, '2018-11-24 01:33:05', 6, '2018-11-24 01:33:05');
INSERT INTO `mv_article` VALUES (9, '街道开展慰问活动', '<p>街道开展慰问活动</p>', '03', 1, 6, '2018-11-24 01:33:34', 6, '2018-11-24 01:33:34');

-- ----------------------------
-- Table structure for mv_certification
-- ----------------------------
DROP TABLE IF EXISTS `mv_certification`;
CREATE TABLE `mv_certification`  (
  `mctf_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mctf_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '证明名称',
  `mctf_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `mctf_reject_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '驳回原因',
  `mctf_pick_up_time` datetime NULL DEFAULT NULL COMMENT '预计取件时间',
  `mctf_certification_type_id` int(8) NOT NULL COMMENT '证明类型',
  `mctf_attachment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件名称',
  `mctf_attachment_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件url',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mctf_id`) USING BTREE,
  UNIQUE INDEX `idx_mctf_id`(`mctf_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '证明' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_certification
-- ----------------------------
INSERT INTO `mv_certification` VALUES (2, '超级管理员-困难证明', '01', '', '2018-11-22 00:00:00', 1, '客户信息导入模版111.xls', 'static/attachments/20181121/20181121144345b9e02897.xls', 1, '2018-11-21 14:43:53', 1, '2018-11-21 14:43:53');
INSERT INTO `mv_certification` VALUES (3, '困难证明', '02', '附件不存在，请重新申请', '0000-00-00 00:00:00', 1, '新建文本文档 (2).txt', 'static/attachments/20181121/20181121160450b88e6264.txt', 1, '2018-11-21 16:04:52', 1, '2018-11-21 16:04:52');
INSERT INTO `mv_certification` VALUES (4, '困难证明-重新申请', '00', NULL, NULL, 1, '新建文本文档 (2).txt', 'static/attachments/20181121/201811211608005beb9613.txt', 1, '2018-11-21 16:08:02', 1, '2018-11-21 16:08:02');
INSERT INTO `mv_certification` VALUES (5, 'txt有文字申请', '00', NULL, NULL, 1, '新建文本文档.txt', 'static/attachments/20181121/201811211610377e7b841b.txt', 1, '2018-11-21 16:10:39', 1, '2018-11-21 16:10:39');
INSERT INTO `mv_certification` VALUES (6, '计划生育证明', '00', NULL, NULL, 3, '1.jpg', 'static/attachments/20181123/201811230053341238864f.jpg', 6, '2018-11-23 00:53:36', 6, '2018-11-23 00:53:36');

-- ----------------------------
-- Table structure for mv_certification_type
-- ----------------------------
DROP TABLE IF EXISTS `mv_certification_type`;
CREATE TABLE `mv_certification_type`  (
  `mvct_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mvct_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '证明名称',
  `mvct_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '证明描述',
  `mvct_auditor` int(8) NOT NULL COMMENT '证明审核人',
  `mvct_is_need_attachment` int(2) NOT NULL COMMENT '是否需要上传附件',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mvct_id`) USING BTREE,
  UNIQUE INDEX `idx_mvct_id`(`mvct_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '证明类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_certification_type
-- ----------------------------
INSERT INTO `mv_certification_type` VALUES (3, '计划生育证明', '需要将家庭情况说明写成文档打包上传', 6, 1, 6, '2018-11-23 00:46:11', 6, '2018-11-23 00:46:11');

-- ----------------------------
-- Table structure for mv_organization
-- ----------------------------
DROP TABLE IF EXISTS `mv_organization`;
CREATE TABLE `mv_organization`  (
  `mogz_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mogz_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织名称',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mogz_id`) USING BTREE,
  UNIQUE INDEX `idx_mogz_id`(`mogz_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_organization
-- ----------------------------
INSERT INTO `mv_organization` VALUES (1, '幸福村委会', 1, '2018-11-11 15:24:35', 1, '2018-11-11 15:24:38');
INSERT INTO `mv_organization` VALUES (2, '下径村小组', 1, '2018-11-20 19:44:21', 1, '2018-11-20 19:44:21');
INSERT INTO `mv_organization` VALUES (3, '何屋村小组', 1, '2018-11-21 21:19:15', 1, '2018-11-21 21:19:15');

-- ----------------------------
-- Table structure for mv_role
-- ----------------------------
DROP TABLE IF EXISTS `mv_role`;
CREATE TABLE `mv_role`  (
  `mvrl_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mvrl_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mvrl_id`) USING BTREE,
  UNIQUE INDEX `idx_mvrl_id`(`mvrl_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_role
-- ----------------------------
INSERT INTO `mv_role` VALUES (1, '超级管理员', -1, '2018-10-22 00:00:00', -1, '2018-10-22 00:00:00');
INSERT INTO `mv_role` VALUES (2, '系统运维人员', 1, '2018-11-04 18:32:52', 1, '2018-11-11 21:25:42');
INSERT INTO `mv_role` VALUES (4, '村委会管理人员', 1, '2018-11-11 21:26:05', 1, '2018-11-21 18:13:34');
INSERT INTO `mv_role` VALUES (5, '村小组组长', 1, '2018-11-20 19:42:46', 1, '2018-11-21 18:13:20');
INSERT INTO `mv_role` VALUES (7, '村民', 1, '2018-11-20 19:43:22', 1, '2018-11-20 19:43:22');

-- ----------------------------
-- Table structure for mv_role_title_relation
-- ----------------------------
DROP TABLE IF EXISTS `mv_role_title_relation`;
CREATE TABLE `mv_role_title_relation`  (
  `mrtr_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mrtr_role_id` int(8) NOT NULL COMMENT '角色ID',
  `mrtr_title_id` int(8) NOT NULL COMMENT '功能标题ID',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mrtr_id`) USING BTREE,
  UNIQUE INDEX `idx_mrtr_id`(`mrtr_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关联' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_role_title_relation
-- ----------------------------
INSERT INTO `mv_role_title_relation` VALUES (69, 2, 1, 2, '2018-11-22 23:14:38', 2, '2018-11-22 23:14:38');
INSERT INTO `mv_role_title_relation` VALUES (70, 2, 5, 2, '2018-11-22 23:14:38', 2, '2018-11-22 23:14:38');
INSERT INTO `mv_role_title_relation` VALUES (71, 2, 7, 2, '2018-11-22 23:14:38', 2, '2018-11-22 23:14:38');
INSERT INTO `mv_role_title_relation` VALUES (72, 2, 9, 2, '2018-11-22 23:14:38', 2, '2018-11-22 23:14:38');
INSERT INTO `mv_role_title_relation` VALUES (103, 7, 2, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (104, 7, 3, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (105, 7, 4, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (106, 7, 10, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (107, 7, 11, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (108, 7, 12, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (109, 7, 14, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (110, 7, 16, 7, '2018-11-22 23:20:42', 7, '2018-11-22 23:20:42');
INSERT INTO `mv_role_title_relation` VALUES (136, 4, 2, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (137, 4, 3, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (138, 4, 4, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (139, 4, 10, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (140, 4, 11, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (141, 4, 12, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (142, 4, 13, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (143, 4, 14, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (144, 4, 15, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (145, 4, 16, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (146, 4, 17, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (147, 4, 18, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (148, 4, 19, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (149, 4, 20, 4, '2018-11-24 01:32:26', 4, '2018-11-24 01:32:26');
INSERT INTO `mv_role_title_relation` VALUES (150, 5, 1, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (151, 5, 2, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (152, 5, 3, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (153, 5, 4, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (154, 5, 10, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (155, 5, 11, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (156, 5, 12, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (157, 5, 13, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (158, 5, 14, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (159, 5, 15, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (160, 5, 16, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (161, 5, 17, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (162, 5, 18, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');
INSERT INTO `mv_role_title_relation` VALUES (163, 5, 19, 5, '2018-11-24 01:32:34', 5, '2018-11-24 01:32:34');

-- ----------------------------
-- Table structure for mv_title
-- ----------------------------
DROP TABLE IF EXISTS `mv_title`;
CREATE TABLE `mv_title`  (
  `mvtt_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mvtt_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能标题',
  `mvtt_url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题url',
  `mvtt_parent_id` int(8) NOT NULL COMMENT '父功能标题ID',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mvtt_id`) USING BTREE,
  UNIQUE INDEX `idx_mvtt_id`(`mvtt_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '功能标题' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_title
-- ----------------------------
INSERT INTO `mv_title` VALUES (1, '系统管理', '', -1, 1, '2018-10-22 17:33:07', 1, '2018-10-22 17:33:12');
INSERT INTO `mv_title` VALUES (2, '新闻中心', '', -1, 1, '2018-10-22 17:33:47', 1, '2018-10-22 17:33:51');
INSERT INTO `mv_title` VALUES (3, '办事大厅', '', -1, 1, '2018-10-22 17:34:42', 1, '2018-10-22 17:34:45');
INSERT INTO `mv_title` VALUES (4, '阳光村务', '', -1, 1, '2018-10-22 18:21:45', 1, '2018-10-22 18:21:49');
INSERT INTO `mv_title` VALUES (5, '组织管理', 'vmsweb/view/organization/organization.jsp', 1, 1, '2018-10-22 18:37:29', 1, '2018-10-22 18:37:45');
INSERT INTO `mv_title` VALUES (7, '用户管理', 'vmsweb/view/user/user.jsp', 1, 1, '2018-10-22 18:37:40', 1, '2018-10-22 18:37:49');
INSERT INTO `mv_title` VALUES (9, '角色管理', 'vmsweb/view/role/role.jsp', 1, 1, '2018-10-22 18:39:51', 1, '2018-10-22 18:39:55');
INSERT INTO `mv_title` VALUES (10, '公告通知', 'vmsweb/view/article/article.jsp?type=01', 4, 1, '2018-11-16 22:33:49', 1, '2018-11-16 22:33:56');
INSERT INTO `mv_title` VALUES (11, '本村新闻', 'vmsweb/view/article/article.jsp?type=02', 2, 1, '2018-11-20 08:12:33', 1, '2018-11-20 08:12:37');
INSERT INTO `mv_title` VALUES (12, '街道新闻', 'vmsweb/view/article/article.jsp?type=03', 2, 1, '2018-11-20 08:14:27', 1, '2018-11-20 08:14:33');
INSERT INTO `mv_title` VALUES (13, '编辑通知', 'vmsweb/view/article/articleAsEdit.jsp?type=01', 4, 1, '2018-11-20 08:53:30', 1, '2018-11-20 08:53:35');
INSERT INTO `mv_title` VALUES (14, '投诉建议', 'vmsweb/view/advise/advise.jsp', 3, 1, '2018-11-20 20:35:24', 1, '2018-11-20 20:35:28');
INSERT INTO `mv_title` VALUES (15, '投诉建议回复', 'vmsweb/view/advise/adviseResponse.jsp', 3, 1, '2018-11-20 21:32:23', 1, '2018-11-20 21:32:27');
INSERT INTO `mv_title` VALUES (16, '证明申请', 'vmsweb/view/certification/certification.jsp', 3, 1, '2018-11-21 08:59:40', 1, '2018-11-21 08:59:44');
INSERT INTO `mv_title` VALUES (17, '证明申请处理', 'vmsweb/view/certification/certificationProcess.jsp', 3, 1, '2018-11-21 14:44:49', 1, '2018-11-21 14:44:52');
INSERT INTO `mv_title` VALUES (18, '证明类型', 'vmsweb/view/certification/certificationType.jsp', 3, 1, '2018-11-21 18:51:43', 1, '2018-11-21 18:51:47');
INSERT INTO `mv_title` VALUES (19, '编辑本村新闻', 'vmsweb/view/article/articleAsEdit.jsp?type=02', 2, 1, '2018-11-24 01:31:44', 1, '2018-11-24 01:31:47');
INSERT INTO `mv_title` VALUES (20, '编辑街道新闻', 'vmsweb/view/article/articleAsEdit.jsp?type=03', 2, 1, '2018-11-24 01:31:55', 1, '2018-11-24 01:31:58');

-- ----------------------------
-- Table structure for mv_user
-- ----------------------------
DROP TABLE IF EXISTS `mv_user`;
CREATE TABLE `mv_user`  (
  `mvus_id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mvus_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `mvus_login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `mvus_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `mvus_gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别（M男 F女）',
  `mvus_mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号',
  `mvus_mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `mvus_organization_id` int(8) NOT NULL COMMENT '组织ID',
  `mvus_role_id` int(8) NOT NULL COMMENT '角色ID',
  `creator` int(8) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modifier` int(8) NOT NULL COMMENT '修改者',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`mvus_id`) USING BTREE,
  UNIQUE INDEX `idx_mvus_id`(`mvus_id`) USING BTREE COMMENT '主键索引'
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mv_user
-- ----------------------------
INSERT INTO `mv_user` VALUES (1, '超级管理员', 'admin', '123456', '男', 'liaozhixing95@163.com', NULL, -1, 1, -1, '2018-10-22 00:00:00', -1, '2018-10-22 00:00:00');
INSERT INTO `mv_user` VALUES (3, '廖志行', 'liaozhixing', '123456', 'M', '13226314212', '441381199507232416', 1, 2, 1, '2018-11-15 22:13:16', 1, '2018-11-22 23:16:16');
INSERT INTO `mv_user` VALUES (4, '廖欣蕊', 'liaoxinrui', '111111', 'F', '13226314250', '441381196001095821', 2, 5, 1, '2018-11-20 19:46:42', 1, '2018-11-20 19:46:42');
INSERT INTO `mv_user` VALUES (5, '张三', 'zhangsan', '111111', 'F', '15521130104', '441381199507312418', 2, 7, 1, '2018-11-20 20:37:09', 1, '2018-11-20 20:37:09');
INSERT INTO `mv_user` VALUES (6, '刘玉玲', 'liuyuling', '111111', 'F', '18207529193', '44130219600109842X', 1, 4, 3, '2018-11-21 18:19:12', 3, '2018-11-21 18:19:12');
INSERT INTO `mv_user` VALUES (7, '何伟明', 'heweiming', '111111', 'M', '441381199507312418', '15521130104', 3, 5, 1, '2018-11-21 21:18:59', 1, '2018-11-21 21:19:42');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('clusteredScheduler', 'triggertest01', 'test', '*/5 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('clusteredScheduler', 'test01', 'test', '测试任务', 'com.tools.module.app.task.ToolsJob', '0', '1', '0', '0', 0xEFBFBDEFBFBD0005737200156F72672E71756172747A2E4A6F62446174614D6170EFBFBDEFBFBDEFBFBDE8BFA9EFBFBDEFBFBD020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D6170EFBFBD08EFBFBDEFBFBDEFBFBDEFBFBD5D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013EFBFBD2EEFBFBD28760AEFBFBD0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507EFBFBDEFBFBDEFBFBD1660EFBFBD03000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000A6D6574686F644E616D6574000574657374317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('clusteredScheduler', 'LAPTOP-ND844EUA1598057146216', 1598057483870, 10000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('clusteredScheduler', 'triggertest01', 'test', 'test01', 'test', NULL, 1590220175000, 1590220170000, 5, 'PAUSED', 'CRON', 1590206928000, 0, NULL, 0, '');

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `area_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '区域id',
  `area_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '行政区划代码',
  `parent_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级id',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区名称',
  `layer` int(11) NULL DEFAULT NULL COMMENT '层级1:省级,2:地市,3:区县',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序号,',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '显示,1:显示,0:隐藏',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7032 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行政区划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES (1, '421221', '421200', '嘉鱼县', 3, 1775, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3, '440282', '440200', '南雄市', 3, 1953, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5, '440301', '440300', '市辖区', 3, 1954, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7, '440303', '440300', '罗湖区', 3, 1955, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (9, '440304', '440300', '福田区', 3, 1956, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (11, '440305', '440300', '南山区', 3, 1957, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (13, '440306', '440300', '宝安区', 3, 1958, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (15, '440307', '440300', '龙岗区', 3, 1959, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (17, '440308', '440300', '盐田区', 3, 1960, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (19, '440401', '440400', '市辖区', 3, 1961, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (21, '440402', '440400', '香洲区', 3, 1962, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (23, '440403', '440400', '斗门区', 3, 1963, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (25, '440404', '440400', '金湾区', 3, 1964, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (27, '440501', '440500', '市辖区', 3, 1965, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (29, '440507', '440500', '龙湖区', 3, 1966, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (31, '440511', '440500', '金平区', 3, 1967, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (33, '440512', '440500', '濠江区', 3, 1968, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (35, '440513', '440500', '潮阳区', 3, 1969, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (37, '440514', '440500', '潮南区', 3, 1970, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (39, '440515', '440500', '澄海区', 3, 1971, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (41, '440523', '440500', '南澳县', 3, 1972, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (43, '440601', '440600', '市辖区', 3, 1973, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (45, '440604', '440600', '禅城区', 3, 1974, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (47, '440605', '440600', '南海区', 3, 1975, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (49, '440606', '440600', '顺德区', 3, 1976, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (51, '440607', '440600', '三水区', 3, 1977, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (53, '440608', '440600', '高明区', 3, 1978, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (55, '440701', '440700', '市辖区', 3, 1979, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (57, '440703', '440700', '蓬江区', 3, 1980, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (59, '440704', '440700', '江海区', 3, 1981, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (61, '440705', '440700', '新会区', 3, 1982, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (63, '440781', '440700', '台山市', 3, 1983, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (65, '440783', '440700', '开平市', 3, 1984, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (67, '440784', '440700', '鹤山市', 3, 1985, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (69, '440785', '440700', '恩平市', 3, 1986, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (71, '440801', '440800', '市辖区', 3, 1987, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (73, '440802', '440800', '赤坎区', 3, 1988, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (75, '440803', '440800', '霞山区', 3, 1989, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (77, '440804', '440800', '坡头区', 3, 1990, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (79, '440811', '440800', '麻章区', 3, 1991, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (81, '440823', '440800', '遂溪县', 3, 1992, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (83, '440825', '440800', '徐闻县', 3, 1993, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (85, '440881', '440800', '廉江市', 3, 1994, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (87, '440882', '440800', '雷州市', 3, 1995, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (89, '440883', '440800', '吴川市', 3, 1996, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (91, '440901', '440900', '市辖区', 3, 1997, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (93, '440902', '440900', '茂南区', 3, 1998, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (95, '440904', '440900', '电白区', 3, 2000, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (97, '440981', '440900', '高州市', 3, 2001, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (99, '440982', '440900', '化州市', 3, 2002, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (101, '440983', '440900', '信宜市', 3, 2003, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (103, '441201', '441200', '市辖区', 3, 2004, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (105, '441202', '441200', '端州区', 3, 2005, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (107, '441203', '441200', '鼎湖区', 3, 2006, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (109, '441223', '441200', '广宁县', 3, 2008, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (111, '441224', '441200', '怀集县', 3, 2009, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (113, '441225', '441200', '封开县', 3, 2010, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (115, '441226', '441200', '德庆县', 3, 2011, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (117, '441204', '441200', '高要区', 3, 2007, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (119, '441284', '441200', '四会市', 3, 2012, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (121, '441301', '441300', '市辖区', 3, 2013, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (123, '441302', '441300', '惠城区', 3, 2014, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (125, '441303', '441300', '惠阳区', 3, 2015, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (127, '441322', '441300', '博罗县', 3, 2016, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (129, '441323', '441300', '惠东县', 3, 2017, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (131, '441324', '441300', '龙门县', 3, 2018, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (133, '441401', '441400', '市辖区', 3, 2019, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (135, '441402', '441400', '梅江区', 3, 2020, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (137, '441403', '441400', '梅县区', 3, 2021, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (139, '441422', '441400', '大埔县', 3, 2022, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (141, '441423', '441400', '丰顺县', 3, 2023, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (143, '441424', '441400', '五华县', 3, 2024, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (145, '441426', '441400', '平远县', 3, 2025, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (147, '441427', '441400', '蕉岭县', 3, 2026, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (149, '441481', '441400', '兴宁市', 3, 2027, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (151, '441501', '441500', '市辖区', 3, 2028, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (153, '441502', '441500', '城区', 3, 2029, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (155, '441521', '441500', '海丰县', 3, 2030, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (157, '441523', '441500', '陆河县', 3, 2031, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (159, '441581', '441500', '陆丰市', 3, 2032, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (161, '441601', '441600', '市辖区', 3, 2033, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (163, '441602', '441600', '源城区', 3, 2034, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (165, '441621', '441600', '紫金县', 3, 2035, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (167, '441622', '441600', '龙川县', 3, 2036, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (169, '441623', '441600', '连平县', 3, 2037, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (171, '441624', '441600', '和平县', 3, 2038, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (173, '441625', '441600', '东源县', 3, 2039, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (175, '441701', '441700', '市辖区', 3, 2040, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (177, '430726', '430700', '石门县', 3, 1865, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (179, '430781', '430700', '津市市', 3, 1866, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (181, '430801', '430800', '市辖区', 3, 1867, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (183, '430802', '430800', '永定区', 3, 1868, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (185, '430811', '430800', '武陵源区', 3, 1869, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (187, '430821', '430800', '慈利县', 3, 1870, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (189, '430822', '430800', '桑植县', 3, 1871, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (191, '430901', '430900', '市辖区', 3, 1872, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (193, '430902', '430900', '资阳区', 3, 1873, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (195, '430903', '430900', '赫山区', 3, 1874, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (197, '430921', '430900', '南县', 3, 1875, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (199, '430922', '430900', '桃江县', 3, 1876, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (201, '430923', '430900', '安化县', 3, 1877, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (203, '430981', '430900', '沅江市', 3, 1878, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (205, '431001', '431000', '市辖区', 3, 1879, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (207, '431002', '431000', '北湖区', 3, 1880, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (209, '431003', '431000', '苏仙区', 3, 1881, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (211, '431021', '431000', '桂阳县', 3, 1882, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (213, '431022', '431000', '宜章县', 3, 1883, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (215, '431023', '431000', '永兴县', 3, 1884, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (217, '431024', '431000', '嘉禾县', 3, 1885, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (219, '431025', '431000', '临武县', 3, 1886, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (221, '431026', '431000', '汝城县', 3, 1887, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (223, '431027', '431000', '桂东县', 3, 1888, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (225, '431028', '431000', '安仁县', 3, 1889, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (227, '431081', '431000', '资兴市', 3, 1890, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (229, '431101', '431100', '市辖区', 3, 1891, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (231, '431102', '431100', '零陵区', 3, 1892, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (233, '431103', '431100', '冷水滩区', 3, 1893, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (235, '431121', '431100', '祁阳县', 3, 1894, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (237, '431122', '431100', '东安县', 3, 1895, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (239, '431123', '431100', '双牌县', 3, 1896, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (241, '431124', '431100', '道县', 3, 1897, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (243, '431125', '431100', '江永县', 3, 1898, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (245, '431126', '431100', '宁远县', 3, 1899, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (247, '431127', '431100', '蓝山县', 3, 1900, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (249, '431128', '431100', '新田县', 3, 1901, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (251, '431129', '431100', '江华瑶族自治县', 3, 1902, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (253, '431201', '431200', '市辖区', 3, 1903, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (255, '431202', '431200', '鹤城区', 3, 1904, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (257, '431221', '431200', '中方县', 3, 1905, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (259, '431222', '431200', '沅陵县', 3, 1906, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (261, '431223', '431200', '辰溪县', 3, 1907, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (263, '431224', '431200', '溆浦县', 3, 1908, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (265, '431225', '431200', '会同县', 3, 1909, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (267, '431226', '431200', '麻阳苗族自治县', 3, 1910, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (269, '431227', '431200', '新晃侗族自治县', 3, 1911, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (271, '431228', '431200', '芷江侗族自治县', 3, 1912, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (273, '431229', '431200', '靖州苗族侗族自治县', 3, 1913, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (275, '431230', '431200', '通道侗族自治县', 3, 1914, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (277, '431281', '431200', '洪江市', 3, 1915, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (279, '431301', '431300', '市辖区', 3, 1916, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (281, '431302', '431300', '娄星区', 3, 1917, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (283, '431321', '431300', '双峰县', 3, 1918, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (285, '431322', '431300', '新化县', 3, 1919, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (287, '431381', '431300', '冷水江市', 3, 1920, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (289, '431382', '431300', '涟源市', 3, 1921, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (291, '433101', '433100', '吉首市', 3, 1922, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (293, '433122', '433100', '泸溪县', 3, 1923, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (295, '433123', '433100', '凤凰县', 3, 1924, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (297, '433124', '433100', '花垣县', 3, 1925, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (299, '433125', '433100', '保靖县', 3, 1926, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (301, '433126', '433100', '古丈县', 3, 1927, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (303, '433127', '433100', '永顺县', 3, 1928, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (305, '433130', '433100', '龙山县', 3, 1929, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (307, '440101', '440100', '市辖区', 3, 1930, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (309, '440115', '440100', '南沙区', 3, 1941, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (311, '440103', '440100', '荔湾区', 3, 1932, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (313, '440104', '440100', '越秀区', 3, 1933, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (315, '440105', '440100', '海珠区', 3, 1934, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (317, '440106', '440100', '天河区', 3, 1935, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (319, '440111', '440100', '白云区', 3, 1937, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (321, '440112', '440100', '黄埔区', 3, 1938, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (323, '440113', '440100', '番禺区', 3, 1939, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (325, '440114', '440100', '花都区', 3, 1940, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (327, '440118', '440100', '增城区', 3, 1943, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (329, '440117', '440100', '从化区', 3, 1942, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (331, '440201', '440200', '市辖区', 3, 1943, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (333, '440203', '440200', '武江区', 3, 1944, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (335, '440204', '440200', '浈江区', 3, 1945, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (337, '440205', '440200', '曲江区', 3, 1946, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (339, '440222', '440200', '始兴县', 3, 1947, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (341, '440224', '440200', '仁化县', 3, 1948, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (343, '440229', '440200', '翁源县', 3, 1949, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (345, '440232', '440200', '乳源瑶族自治县', 3, 1950, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (347, '440233', '440200', '新丰县', 3, 1951, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (349, '440281', '440200', '乐昌市', 3, 1952, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (351, '331125', '331100', '云和县', 3, 1018, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (353, '331126', '331100', '庆元县', 3, 1019, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (355, '331127', '331100', '景宁畲族自治县', 3, 1020, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (357, '331181', '331100', '龙泉市', 3, 1021, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (359, '340101', '340100', '市辖区', 3, 1022, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (361, '340102', '340100', '瑶海区', 3, 1023, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (363, '340103', '340100', '庐阳区', 3, 1024, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (365, '340104', '340100', '蜀山区', 3, 1025, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (367, '340111', '340100', '包河区', 3, 1026, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (369, '340121', '340100', '长丰县', 3, 1027, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (371, '340122', '340100', '肥东县', 3, 1028, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (373, '340123', '340100', '肥西县', 3, 1029, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (375, '340201', '340200', '市辖区', 3, 1030, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (377, '340202', '340200', '镜湖区', 3, 1031, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (379, '340203', '340200', '弋江区', 3, 1032, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (381, '340208', '340200', '三山区', 3, 1034, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (383, '340207', '340200', '鸠江区', 3, 1033, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (385, '340221', '340200', '芜湖县', 3, 1035, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (387, '340222', '340200', '繁昌县', 3, 1036, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (389, '340223', '340200', '南陵县', 3, 1037, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (391, '340301', '340300', '市辖区', 3, 1038, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (393, '340302', '340300', '龙子湖区', 3, 1039, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (395, '340303', '340300', '蚌山区', 3, 1040, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (397, '340304', '340300', '禹会区', 3, 1041, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (399, '340311', '340300', '淮上区', 3, 1042, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (401, '340321', '340300', '怀远县', 3, 1043, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (403, '340322', '340300', '五河县', 3, 1044, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (405, '340323', '340300', '固镇县', 3, 1045, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (407, '340401', '340400', '市辖区', 3, 1046, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (409, '340402', '340400', '大通区', 3, 1047, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (411, '340403', '340400', '田家庵区', 3, 1048, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (413, '340404', '340400', '谢家集区', 3, 1049, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (415, '340405', '340400', '八公山区', 3, 1050, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (417, '340406', '340400', '潘集区', 3, 1051, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (419, '340421', '340400', '凤台县', 3, 1052, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (421, '340501', '340500', '市辖区', 3, 1053, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (423, '340506', '340500', '博望区', 3, 1056, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (425, '340503', '340500', '花山区', 3, 1054, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (427, '340504', '340500', '雨山区', 3, 1055, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (429, '340521', '340500', '当涂县', 3, 1057, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (431, '340601', '340600', '市辖区', 3, 1058, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (433, '340602', '340600', '杜集区', 3, 1059, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (435, '340603', '340600', '相山区', 3, 1060, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (437, '340604', '340600', '烈山区', 3, 1061, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (439, '340621', '340600', '濉溪县', 3, 1062, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (441, '340701', '340700', '市辖区', 3, 1063, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (443, '340711', '340700', '郊区', 3, 1066, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (445, '340801', '340800', '市辖区', 3, 1068, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (447, '340802', '340800', '迎江区', 3, 1069, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (449, '340803', '340800', '大观区', 3, 1070, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (451, '340811', '340800', '宜秀区', 3, 1071, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (453, '340822', '340800', '怀宁县', 3, 1072, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (455, '340824', '340800', '潜山县', 3, 1074, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (457, '340825', '340800', '太湖县', 3, 1075, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (459, '340826', '340800', '宿松县', 3, 1076, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (461, '340827', '340800', '望江县', 3, 1077, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (463, '340828', '340800', '岳西县', 3, 1078, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (465, '340881', '340800', '桐城市', 3, 1079, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (467, '341001', '341000', '市辖区', 3, 1080, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (469, '341002', '341000', '屯溪区', 3, 1081, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (471, '341003', '341000', '黄山区', 3, 1082, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (473, '341004', '341000', '徽州区', 3, 1083, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (475, '341021', '341000', '歙县', 3, 1084, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (477, '341022', '341000', '休宁县', 3, 1085, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (479, '341023', '341000', '黟县', 3, 1086, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (481, '341024', '341000', '祁门县', 3, 1087, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (483, '341101', '341100', '市辖区', 3, 1088, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (485, '341102', '341100', '琅琊区', 3, 1089, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (487, '341103', '341100', '南谯区', 3, 1090, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (489, '341122', '341100', '来安县', 3, 1091, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (491, '341124', '341100', '全椒县', 3, 1092, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (493, '341125', '341100', '定远县', 3, 1093, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (495, '341126', '341100', '凤阳县', 3, 1094, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (497, '341181', '341100', '天长市', 3, 1095, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (499, '341182', '341100', '明光市', 3, 1096, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (501, '341201', '341200', '市辖区', 3, 1097, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (503, '341202', '341200', '颍州区', 3, 1098, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (505, '341203', '341200', '颍东区', 3, 1099, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (507, '341204', '341200', '颍泉区', 3, 1100, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (509, '341221', '341200', '临泉县', 3, 1101, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (511, '341222', '341200', '太和县', 3, 1102, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (513, '341225', '341200', '阜南县', 3, 1103, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (515, '341226', '341200', '颍上县', 3, 1104, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (517, '341282', '341200', '界首市', 3, 1105, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (519, '341301', '341300', '市辖区', 3, 1106, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (521, '341302', '341300', '埇桥区', 3, 1107, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (523, '341321', '341300', '砀山县', 3, 1108, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (525, '341322', '341300', '萧县', 3, 1109, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (527, '341323', '341300', '灵璧县', 3, 1110, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (529, '341324', '341300', '泗县', 3, 1111, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (531, '341501', '341500', '市辖区', 3, 1118, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (533, '341502', '341500', '金安区', 3, 1119, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (535, '341503', '341500', '裕安区', 3, 1120, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (537, '341522', '341500', '霍邱县', 3, 1122, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (539, '341523', '341500', '舒城县', 3, 1123, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (541, '341524', '341500', '金寨县', 3, 1124, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (543, '341525', '341500', '霍山县', 3, 1125, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (545, '341601', '341600', '市辖区', 3, 1126, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (547, '341602', '341600', '谯城区', 3, 1127, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (549, '341621', '341600', '涡阳县', 3, 1128, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (551, '341622', '341600', '蒙城县', 3, 1129, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (553, '341623', '341600', '利辛县', 3, 1130, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (555, '341701', '341700', '市辖区', 3, 1131, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (557, '341702', '341700', '贵池区', 3, 1132, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (559, '341721', '341700', '东至县', 3, 1133, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (561, '341722', '341700', '石台县', 3, 1134, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (563, '341723', '341700', '青阳县', 3, 1135, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (565, '341801', '341800', '市辖区', 3, 1136, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (567, '341802', '341800', '宣州区', 3, 1137, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (569, '341821', '341800', '郎溪县', 3, 1138, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (571, '341822', '341800', '广德县', 3, 1139, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (573, '341823', '341800', '泾县', 3, 1140, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (575, '341824', '341800', '绩溪县', 3, 1141, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (577, '341825', '341800', '旌德县', 3, 1142, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (579, '341881', '341800', '宁国市', 3, 1143, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (581, '350101', '350100', '市辖区', 3, 1144, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (583, '350102', '350100', '鼓楼区', 3, 1145, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (585, '350103', '350100', '台江区', 3, 1146, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (587, '420602', '420600', '襄城区', 3, 1726, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (589, '420606', '420600', '樊城区', 3, 1727, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (591, '420607', '420600', '襄州区', 3, 1728, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (593, '420624', '420600', '南漳县', 3, 1729, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (595, '420625', '420600', '谷城县', 3, 1730, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (597, '420626', '420600', '保康县', 3, 1731, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (599, '420682', '420600', '老河口市', 3, 1732, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (601, '420683', '420600', '枣阳市', 3, 1733, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (603, '420684', '420600', '宜城市', 3, 1734, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (605, '420701', '420700', '市辖区', 3, 1735, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (607, '420702', '420700', '梁子湖区', 3, 1736, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (609, '420703', '420700', '华容区', 3, 1737, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (611, '420704', '420700', '鄂城区', 3, 1738, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (613, '420801', '420800', '市辖区', 3, 1739, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (615, '420802', '420800', '东宝区', 3, 1740, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (617, '420804', '420800', '掇刀区', 3, 1741, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (619, '420821', '420800', '京山县', 3, 1742, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (621, '420822', '420800', '沙洋县', 3, 1743, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (623, '420881', '420800', '钟祥市', 3, 1744, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (625, '420901', '420900', '市辖区', 3, 1745, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (627, '420902', '420900', '孝南区', 3, 1746, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (629, '420921', '420900', '孝昌县', 3, 1747, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (631, '420922', '420900', '大悟县', 3, 1748, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (633, '420923', '420900', '云梦县', 3, 1749, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (635, '420981', '420900', '应城市', 3, 1750, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (637, '420982', '420900', '安陆市', 3, 1751, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (639, '420984', '420900', '汉川市', 3, 1752, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (641, '421001', '421000', '市辖区', 3, 1753, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (643, '421002', '421000', '沙市区', 3, 1754, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (645, '421003', '421000', '荆州区', 3, 1755, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (647, '421022', '421000', '公安县', 3, 1756, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (649, '421023', '421000', '监利县', 3, 1757, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (651, '421024', '421000', '江陵县', 3, 1758, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (653, '421081', '421000', '石首市', 3, 1759, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (655, '421083', '421000', '洪湖市', 3, 1760, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (657, '421087', '421000', '松滋市', 3, 1761, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (659, '421101', '421100', '市辖区', 3, 1762, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (661, '421102', '421100', '黄州区', 3, 1763, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (663, '421121', '421100', '团风县', 3, 1764, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (665, '421122', '421100', '红安县', 3, 1765, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (667, '421123', '421100', '罗田县', 3, 1766, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (669, '421124', '421100', '英山县', 3, 1767, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (671, '421125', '421100', '浠水县', 3, 1768, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (673, '421126', '421100', '蕲春县', 3, 1769, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (675, '421127', '421100', '黄梅县', 3, 1770, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (677, '421181', '421100', '麻城市', 3, 1771, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (679, '421182', '421100', '武穴市', 3, 1772, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (681, '421201', '421200', '市辖区', 3, 1773, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (683, '421202', '421200', '咸安区', 3, 1774, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (685, '421222', '421200', '通城县', 3, 1776, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (687, '421223', '421200', '崇阳县', 3, 1777, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (689, '421224', '421200', '通山县', 3, 1778, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (691, '421281', '421200', '赤壁市', 3, 1779, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (693, '421301', '421300', '市辖区', 3, 1780, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (695, '421303', '421300', '曾都区', 3, 1781, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (697, '421381', '421300', '广水市', 3, 1783, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (699, '422801', '422800', '恩施市', 3, 1783, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (701, '422802', '422800', '利川市', 3, 1784, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (703, '422822', '422800', '建始县', 3, 1785, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (705, '422823', '422800', '巴东县', 3, 1786, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (707, '422825', '422800', '宣恩县', 3, 1787, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (709, '422826', '422800', '咸丰县', 3, 1788, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (711, '422827', '422800', '来凤县', 3, 1789, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (713, '422828', '422800', '鹤峰县', 3, 1790, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (715, '429004', '429000', '仙桃市', 3, 1791, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (717, '429005', '429000', '潜江市', 3, 1792, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (719, '429006', '429000', '天门市', 3, 1793, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (721, '429021', '429000', '神农架林区', 3, 1794, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (723, '430101', '430100', '市辖区', 3, 1795, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (725, '430102', '430100', '芙蓉区', 3, 1796, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (727, '430103', '430100', '天心区', 3, 1797, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (729, '430104', '430100', '岳麓区', 3, 1798, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (731, '430105', '430100', '开福区', 3, 1799, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (733, '430111', '430100', '雨花区', 3, 1800, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (735, '430121', '430100', '长沙县', 3, 1802, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (737, '430112', '430100', '望城区', 3, 1801, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (739, '430124', '430100', '宁乡县', 3, 1803, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (741, '430181', '430100', '浏阳市', 3, 1804, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (743, '430201', '430200', '市辖区', 3, 1805, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (745, '430202', '430200', '荷塘区', 3, 1806, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (747, '430203', '430200', '芦淞区', 3, 1807, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (749, '430204', '430200', '石峰区', 3, 1808, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (751, '430211', '430200', '天元区', 3, 1809, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (753, '430221', '430200', '株洲县', 3, 1810, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (755, '430223', '430200', '攸县', 3, 1811, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (757, '430224', '430200', '茶陵县', 3, 1812, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (759, '430225', '430200', '炎陵县', 3, 1813, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (761, '430281', '430200', '醴陵市', 3, 1814, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (763, '430301', '430300', '市辖区', 3, 1815, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (765, '430302', '430300', '雨湖区', 3, 1816, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (767, '430304', '430300', '岳塘区', 3, 1817, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (769, '430321', '430300', '湘潭县', 3, 1818, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (771, '430381', '430300', '湘乡市', 3, 1819, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (773, '430382', '430300', '韶山市', 3, 1820, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (775, '430401', '430400', '市辖区', 3, 1821, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (777, '430405', '430400', '珠晖区', 3, 1822, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (779, '430406', '430400', '雁峰区', 3, 1823, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (781, '430407', '430400', '石鼓区', 3, 1824, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (783, '430408', '430400', '蒸湘区', 3, 1825, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (785, '430412', '430400', '南岳区', 3, 1826, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (787, '430421', '430400', '衡阳县', 3, 1827, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (789, '430422', '430400', '衡南县', 3, 1828, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (791, '430423', '430400', '衡山县', 3, 1829, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (793, '430424', '430400', '衡东县', 3, 1830, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (795, '430426', '430400', '祁东县', 3, 1831, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (797, '430481', '430400', '耒阳市', 3, 1832, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (799, '430482', '430400', '常宁市', 3, 1833, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (801, '430501', '430500', '市辖区', 3, 1834, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (803, '430502', '430500', '双清区', 3, 1835, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (805, '430503', '430500', '大祥区', 3, 1836, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (807, '430511', '430500', '北塔区', 3, 1837, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (809, '430521', '430500', '邵东县', 3, 1838, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (811, '430522', '430500', '新邵县', 3, 1839, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (813, '430523', '430500', '邵阳县', 3, 1840, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (815, '430524', '430500', '隆回县', 3, 1841, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (817, '430525', '430500', '洞口县', 3, 1842, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (819, '430527', '430500', '绥宁县', 3, 1843, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (821, '430528', '430500', '新宁县', 3, 1844, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (823, '430529', '430500', '城步苗族自治县', 3, 1845, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (825, '430581', '430500', '武冈市', 3, 1846, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (827, '430601', '430600', '市辖区', 3, 1847, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (829, '430602', '430600', '岳阳楼区', 3, 1848, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (831, '430603', '430600', '云溪区', 3, 1849, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (833, '430611', '430600', '君山区', 3, 1850, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (835, '430621', '430600', '岳阳县', 3, 1851, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (837, '430623', '430600', '华容县', 3, 1852, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (839, '430624', '430600', '湘阴县', 3, 1853, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (841, '430626', '430600', '平江县', 3, 1854, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (843, '430681', '430600', '汨罗市', 3, 1855, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (845, '430682', '430600', '临湘市', 3, 1856, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (847, '430701', '430700', '市辖区', 3, 1857, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (849, '430702', '430700', '武陵区', 3, 1858, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (851, '430703', '430700', '鼎城区', 3, 1859, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (853, '430721', '430700', '安乡县', 3, 1860, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (855, '430722', '430700', '汉寿县', 3, 1861, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (857, '430723', '430700', '澧县', 3, 1862, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (859, '430724', '430700', '临澧县', 3, 1863, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (861, '430725', '430700', '桃源县', 3, 1864, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (863, '441702', '441700', '江城区', 3, 2041, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (865, '441721', '441700', '阳西县', 3, 2043, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (867, '441704', '441700', '阳东区', 3, 2042, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (869, '441781', '441700', '阳春市', 3, 2044, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (871, '441801', '441800', '市辖区', 3, 2045, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (873, '441802', '441800', '清城区', 3, 2046, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (875, '441821', '441800', '佛冈县', 3, 2048, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (877, '441823', '441800', '阳山县', 3, 2049, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (879, '441825', '441800', '连山壮族瑶族自治县', 3, 2050, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (881, '441826', '441800', '连南瑶族自治县', 3, 2051, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (883, '441803', '441800', '清新区', 3, 2017, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (885, '441881', '441800', '英德市', 3, 2052, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (887, '441882', '441800', '连州市', 3, 2053, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (889, '445101', '445100', '市辖区', 3, 2054, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (891, '445102', '445100', '湘桥区', 3, 2055, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (893, '445103', '445100', '潮安区', 3, 2056, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (895, '445122', '445100', '饶平县', 3, 2057, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (897, '445201', '445200', '市辖区', 3, 2058, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (899, '445202', '445200', '榕城区', 3, 2059, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (901, '445203', '445200', '揭东区', 3, 2060, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (903, '445222', '445200', '揭西县', 3, 2061, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (905, '445224', '445200', '惠来县', 3, 2062, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (907, '445281', '445200', '普宁市', 3, 2063, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (909, '445301', '445300', '市辖区', 3, 2064, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (911, '445302', '445300', '云城区', 3, 2065, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (913, '445321', '445300', '新兴县', 3, 2067, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (915, '445322', '445300', '郁南县', 3, 2068, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (917, '445303', '445300', '云安区', 3, 2066, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (919, '445381', '445300', '罗定市', 3, 2069, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (921, '450101', '450100', '市辖区', 3, 2070, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (923, '450102', '450100', '兴宁区', 3, 2071, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (925, '450103', '450100', '青秀区', 3, 2072, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (927, '450105', '450100', '江南区', 3, 2073, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (929, '450107', '450100', '西乡塘区', 3, 2074, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (931, '450108', '450100', '良庆区', 3, 2075, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (933, '450109', '450100', '邕宁区', 3, 2076, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (935, '450110', '450100', '武鸣区', 3, 2077, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (937, '450123', '450100', '隆安县', 3, 2078, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (939, '450124', '450100', '马山县', 3, 2079, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (941, '450125', '450100', '上林县', 3, 2080, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (943, '450126', '450100', '宾阳县', 3, 2081, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (945, '450127', '450100', '横县', 3, 2082, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (947, '450201', '450200', '市辖区', 3, 2083, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (949, '450202', '450200', '城中区', 3, 2084, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (951, '450203', '450200', '鱼峰区', 3, 2085, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (953, '450204', '450200', '柳南区', 3, 2086, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (955, '450205', '450200', '柳北区', 3, 2087, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (957, '450222', '450200', '柳城县', 3, 2089, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (959, '450223', '450200', '鹿寨县', 3, 2090, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (961, '450224', '450200', '融安县', 3, 2091, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (963, '450225', '450200', '融水苗族自治县', 3, 2092, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (965, '450226', '450200', '三江侗族自治县', 3, 2093, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (967, '450301', '450300', '市辖区', 3, 2094, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (969, '450302', '450300', '秀峰区', 3, 2095, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (971, '450303', '450300', '叠彩区', 3, 2096, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (973, '450304', '450300', '象山区', 3, 2097, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (975, '450305', '450300', '七星区', 3, 2098, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (977, '450311', '450300', '雁山区', 3, 2099, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (979, '450321', '450300', '阳朔县', 3, 2101, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (981, '450312', '450300', '临桂区', 3, 2100, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (983, '450323', '450300', '灵川县', 3, 2102, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (985, '450324', '450300', '全州县', 3, 2103, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (987, '450325', '450300', '兴安县', 3, 2104, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (989, '450326', '450300', '永福县', 3, 2105, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (991, '450327', '450300', '灌阳县', 3, 2106, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (993, '450328', '450300', '龙胜各族自治县', 3, 2107, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (995, '450329', '450300', '资源县', 3, 2108, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (997, '450330', '450300', '平乐县', 3, 2109, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (999, '450331', '450300', '荔浦县', 3, 2110, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1001, '450332', '450300', '恭城瑶族自治县', 3, 2111, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1003, '450401', '450400', '市辖区', 3, 2112, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1005, '450403', '450400', '万秀区', 3, 2113, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1007, '450406', '450400', '龙圩区', 3, 2115, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1009, '450405', '450400', '长洲区', 3, 2114, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1011, '450421', '450400', '苍梧县', 3, 2116, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1013, '450422', '450400', '藤县', 3, 2117, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1015, '450423', '450400', '蒙山县', 3, 2118, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1017, '450481', '450400', '岑溪市', 3, 2119, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1019, '450501', '450500', '市辖区', 3, 2120, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1021, '450502', '450500', '海城区', 3, 2121, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1023, '450503', '450500', '银海区', 3, 2122, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1025, '450512', '450500', '铁山港区', 3, 2123, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1027, '450521', '450500', '合浦县', 3, 2124, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1029, '450601', '450600', '市辖区', 3, 2125, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1031, '450602', '450600', '港口区', 3, 2126, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1033, '450603', '450600', '防城区', 3, 2127, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1035, '450621', '450600', '上思县', 3, 2128, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1037, '230403', '230400', '工农区', 3, 690, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1039, '230404', '230400', '南山区', 3, 691, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1041, '230405', '230400', '兴安区', 3, 692, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1043, '230406', '230400', '东山区', 3, 693, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1045, '230407', '230400', '兴山区', 3, 694, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1047, '230421', '230400', '萝北县', 3, 695, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1049, '230422', '230400', '绥滨县', 3, 696, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1051, '230501', '230500', '市辖区', 3, 697, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1053, '230502', '230500', '尖山区', 3, 698, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1055, '230503', '230500', '岭东区', 3, 699, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1057, '230505', '230500', '四方台区', 3, 700, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1059, '230506', '230500', '宝山区', 3, 701, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1061, '230521', '230500', '集贤县', 3, 702, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1063, '230522', '230500', '友谊县', 3, 703, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1065, '230523', '230500', '宝清县', 3, 704, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1067, '230524', '230500', '饶河县', 3, 705, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1069, '230601', '230600', '市辖区', 3, 706, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1071, '230602', '230600', '萨尔图区', 3, 707, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1073, '230603', '230600', '龙凤区', 3, 708, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1075, '230604', '230600', '让胡路区', 3, 709, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1077, '230605', '230600', '红岗区', 3, 710, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1079, '230606', '230600', '大同区', 3, 711, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1081, '230621', '230600', '肇州县', 3, 712, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1083, '230622', '230600', '肇源县', 3, 713, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1085, '230623', '230600', '林甸县', 3, 714, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1087, '230624', '230600', '杜尔伯特蒙古族自治县', 3, 715, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1089, '230701', '230700', '市辖区', 3, 716, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1091, '230702', '230700', '伊春区', 3, 717, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1093, '230703', '230700', '南岔区', 3, 718, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1095, '230704', '230700', '友好区', 3, 719, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1097, '230705', '230700', '西林区', 3, 720, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1099, '230706', '230700', '翠峦区', 3, 721, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1101, '230707', '230700', '新青区', 3, 722, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1103, '230708', '230700', '美溪区', 3, 723, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1105, '230709', '230700', '金山屯区', 3, 724, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1107, '230710', '230700', '五营区', 3, 725, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1109, '230711', '230700', '乌马河区', 3, 726, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1111, '230712', '230700', '汤旺河区', 3, 727, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1113, '230713', '230700', '带岭区', 3, 728, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1115, '230714', '230700', '乌伊岭区', 3, 729, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1117, '230715', '230700', '红星区', 3, 730, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1119, '230716', '230700', '上甘岭区', 3, 731, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1121, '230722', '230700', '嘉荫县', 3, 732, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1123, '230781', '230700', '铁力市', 3, 733, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1125, '230801', '230800', '市辖区', 3, 734, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1127, '230803', '230800', '向阳区', 3, 736, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1129, '230804', '230800', '前进区', 3, 737, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1131, '230805', '230800', '东风区', 3, 738, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1133, '230811', '230800', '郊区', 3, 739, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1135, '230822', '230800', '桦南县', 3, 740, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1137, '230826', '230800', '桦川县', 3, 741, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1139, '230828', '230800', '汤原县', 3, 742, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1141, '230881', '230800', '同江市', 3, 744, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1143, '230882', '230800', '富锦市', 3, 745, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1145, '230901', '230900', '市辖区', 3, 746, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1147, '230902', '230900', '新兴区', 3, 747, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1149, '230903', '230900', '桃山区', 3, 748, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1151, '230904', '230900', '茄子河区', 3, 749, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1153, '230921', '230900', '勃利县', 3, 750, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1155, '231001', '231000', '市辖区', 3, 751, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1157, '231002', '231000', '东安区', 3, 752, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1159, '231003', '231000', '阳明区', 3, 753, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1161, '231004', '231000', '爱民区', 3, 754, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1163, '231005', '231000', '西安区', 3, 755, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1165, '231025', '231000', '林口县', 3, 757, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1167, '231081', '231000', '绥芬河市', 3, 758, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1169, '231083', '231000', '海林市', 3, 759, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1171, '231084', '231000', '宁安市', 3, 760, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1173, '231085', '231000', '穆棱市', 3, 761, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1175, '231101', '231100', '市辖区', 3, 762, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1177, '231102', '231100', '爱辉区', 3, 763, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1179, '231121', '231100', '嫩江县', 3, 764, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1181, '231123', '231100', '逊克县', 3, 765, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1183, '231124', '231100', '孙吴县', 3, 766, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1185, '231181', '231100', '北安市', 3, 767, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1187, '231182', '231100', '五大连池市', 3, 768, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1189, '231201', '231200', '市辖区', 3, 769, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1191, '231202', '231200', '北林区', 3, 770, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1193, '231221', '231200', '望奎县', 3, 771, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1195, '231222', '231200', '兰西县', 3, 772, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1197, '231223', '231200', '青冈县', 3, 773, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1199, '231224', '231200', '庆安县', 3, 774, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1201, '231225', '231200', '明水县', 3, 775, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1203, '231226', '231200', '绥棱县', 3, 776, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1205, '231281', '231200', '安达市', 3, 777, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1207, '231282', '231200', '肇东市', 3, 778, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1209, '231283', '231200', '海伦市', 3, 779, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1211, '232721', '232700', '呼玛县', 3, 780, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1213, '232722', '232700', '塔河县', 3, 781, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1215, '232723', '232700', '漠河县', 3, 782, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1217, '310101', '310100', '黄浦区', 3, 783, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1219, '310104', '310100', '徐汇区', 3, 785, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1221, '310105', '310100', '长宁区', 3, 786, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1223, '310106', '310100', '静安区', 3, 787, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1225, '310107', '310100', '普陀区', 3, 788, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1227, '310109', '310100', '虹口区', 3, 790, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1229, '310110', '310100', '杨浦区', 3, 791, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1231, '310112', '310100', '闵行区', 3, 792, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1233, '310113', '310100', '宝山区', 3, 793, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1235, '310114', '310100', '嘉定区', 3, 794, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1237, '310115', '310100', '浦东新区', 3, 795, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1239, '310116', '310100', '金山区', 3, 796, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1241, '310117', '310100', '松江区', 3, 797, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1243, '310118', '310100', '青浦区', 3, 798, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1245, '310120', '310100', '奉贤区', 3, 800, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1247, '320101', '320100', '市辖区', 3, 802, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1249, '320102', '320100', '玄武区', 3, 803, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1251, '320104', '320100', '秦淮区', 3, 805, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1253, '320105', '320100', '建邺区', 3, 806, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1255, '320106', '320100', '鼓楼区', 3, 807, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1257, '320111', '320100', '浦口区', 3, 809, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1259, '320113', '320100', '栖霞区', 3, 810, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1261, '320114', '320100', '雨花台区', 3, 811, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1263, '320115', '320100', '江宁区', 3, 812, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1265, '320116', '320100', '六合区', 3, 813, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1267, '320117', '320100', '溧水区', 3, 814, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1269, '320118', '320100', '高淳区', 3, 815, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1271, '320201', '320200', '市辖区', 3, 816, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1273, '320205', '320200', '锡山区', 3, 820, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1275, '320206', '320200', '惠山区', 3, 821, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1277, '320211', '320200', '滨湖区', 3, 822, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1279, '320281', '320200', '江阴市', 3, 823, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1281, '320282', '320200', '宜兴市', 3, 824, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1283, '320301', '320300', '市辖区', 3, 825, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1285, '320302', '320300', '鼓楼区', 3, 826, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1287, '320303', '320300', '云龙区', 3, 827, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1289, '320305', '320300', '贾汪区', 3, 828, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1291, '320311', '320300', '泉山区', 3, 829, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1293, '320321', '320300', '丰县', 3, 831, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1295, '320322', '320300', '沛县', 3, 832, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1297, '320312', '320300', '铜山区', 3, 830, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1299, '320324', '320300', '睢宁县', 3, 834, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1301, '320381', '320300', '新沂市', 3, 835, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1303, '320382', '320300', '邳州市', 3, 836, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1305, '320401', '320400', '市辖区', 3, 837, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1307, '320402', '320400', '天宁区', 3, 838, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1309, '320404', '320400', '钟楼区', 3, 839, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1311, '320411', '320400', '新北区', 3, 841, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1313, '320412', '320400', '武进区', 3, 842, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1315, '320481', '320400', '溧阳市', 3, 844, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1317, '320413', '320400', '金坛区', 3, 843, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1319, '320501', '320500', '市辖区', 3, 845, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1321, '320508', '320500', '姑苏区', 3, 849, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1323, '320505', '320500', '虎丘区', 3, 846, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1325, '320506', '320500', '吴中区', 3, 847, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1327, '320507', '320500', '相城区', 3, 848, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1329, '320581', '320500', '常熟市', 3, 852, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1331, '320582', '320500', '张家港市', 3, 853, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1333, '320583', '320500', '昆山市', 3, 854, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1335, '320509', '320500', '吴江区', 3, 850, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1337, '320585', '320500', '太仓市', 3, 856, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1339, '320601', '320600', '市辖区', 3, 857, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1341, '320602', '320600', '崇川区', 3, 858, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1343, '320611', '320600', '港闸区', 3, 859, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1345, '320621', '320600', '海安县', 3, 861, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1347, '320623', '320600', '如东县', 3, 862, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1349, '320681', '320600', '启东市', 3, 863, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1351, '320682', '320600', '如皋市', 3, 864, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1353, '320612', '320600', '通州区', 3, 860, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1355, '320684', '320600', '海门市', 3, 865, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1357, '320701', '320700', '市辖区', 3, 866, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1359, '320703', '320700', '连云区', 3, 867, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1361, '500101', '500100', '万州区', 3, 2218, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1363, '500102', '500100', '涪陵区', 3, 2219, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1365, '500103', '500100', '渝中区', 3, 2220, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1367, '500104', '500100', '大渡口区', 3, 2221, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1369, '500105', '500100', '江北区', 3, 2222, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1371, '500106', '500100', '沙坪坝区', 3, 2223, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1373, '500107', '500100', '九龙坡区', 3, 2224, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1375, '500108', '500100', '南岸区', 3, 2225, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1377, '500109', '500100', '北碚区', 3, 2226, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1379, '500110', '500100', '綦江区', 3, 2227, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1381, '500111', '500100', '大足区', 3, 2228, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1383, '500112', '500100', '渝北区', 3, 2229, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1385, '500113', '500100', '巴南区', 3, 2230, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1387, '500114', '500100', '黔江区', 3, 2231, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1389, '500115', '500100', '长寿区', 3, 2232, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1391, '500228', '500200', '梁平县', 3, 2239, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1393, '500229', '500200', '城口县', 3, 2240, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1395, '500230', '500200', '丰都县', 3, 2241, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1397, '500231', '500200', '垫江县', 3, 2242, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1399, '500232', '500200', '武隆县', 3, 2243, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1401, '500233', '500200', '忠县', 3, 2244, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1403, '500235', '500200', '云阳县', 3, 2246, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1405, '500236', '500200', '奉节县', 3, 2247, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1407, '500237', '500200', '巫山县', 3, 2248, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1409, '500238', '500200', '巫溪县', 3, 2249, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1411, '500240', '500200', '石柱土家族自治县', 3, 2250, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1413, '500241', '500200', '秀山土家族苗族自治县', 3, 2251, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1415, '500242', '500200', '酉阳土家族苗族自治县', 3, 2252, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1417, '500243', '500200', '彭水苗族土家族自治县', 3, 2253, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1419, '510101', '510100', '市辖区', 3, 2258, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1421, '510104', '510100', '锦江区', 3, 2259, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1423, '510105', '510100', '青羊区', 3, 2260, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1425, '510106', '510100', '金牛区', 3, 2261, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1427, '510107', '510100', '武侯区', 3, 2262, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1429, '510108', '510100', '成华区', 3, 2263, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1431, '510112', '510100', '龙泉驿区', 3, 2264, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1433, '510113', '510100', '青白江区', 3, 2265, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1435, '510114', '510100', '新都区', 3, 2266, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1437, '510115', '510100', '温江区', 3, 2267, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1439, '510121', '510100', '金堂县', 3, 2268, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1441, '510124', '510100', '郫县', 3, 2270, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1443, '510129', '510100', '大邑县', 3, 2271, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1445, '510131', '510100', '蒲江县', 3, 2272, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1447, '510132', '510100', '新津县', 3, 2273, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1449, '510181', '510100', '都江堰市', 3, 2274, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1451, '510182', '510100', '彭州市', 3, 2275, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1453, '510183', '510100', '邛崃市', 3, 2276, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1455, '510184', '510100', '崇州市', 3, 2277, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1457, '510301', '510300', '市辖区', 3, 2278, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1459, '510302', '510300', '自流井区', 3, 2279, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1461, '510303', '510300', '贡井区', 3, 2280, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1463, '510304', '510300', '大安区', 3, 2281, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1465, '510311', '510300', '沿滩区', 3, 2282, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1467, '510321', '510300', '荣县', 3, 2283, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1469, '510322', '510300', '富顺县', 3, 2284, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1471, '510401', '510400', '市辖区', 3, 2285, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1473, '510402', '510400', '东区', 3, 2286, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1475, '510403', '510400', '西区', 3, 2287, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1477, '510411', '510400', '仁和区', 3, 2288, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1479, '510421', '510400', '米易县', 3, 2289, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1481, '510422', '510400', '盐边县', 3, 2290, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1483, '510501', '510500', '市辖区', 3, 2291, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1485, '510502', '510500', '江阳区', 3, 2292, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1487, '510503', '510500', '纳溪区', 3, 2293, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1489, '510504', '510500', '龙马潭区', 3, 2294, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1491, '510521', '510500', '泸县', 3, 2295, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1493, '510522', '510500', '合江县', 3, 2296, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1495, '510524', '510500', '叙永县', 3, 2297, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1497, '510525', '510500', '古蔺县', 3, 2298, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1499, '510601', '510600', '市辖区', 3, 2299, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1501, '510603', '510600', '旌阳区', 3, 2300, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1503, '510623', '510600', '中江县', 3, 2301, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1505, '510626', '510600', '罗江县', 3, 2302, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1507, '510681', '510600', '广汉市', 3, 2303, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1509, '510682', '510600', '什邡市', 3, 2304, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1511, '510683', '510600', '绵竹市', 3, 2305, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1513, '230402', '230400', '向阳区', 3, 689, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1515, '330381', '330300', '瑞安市', 3, 957, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1517, '330382', '330300', '乐清市', 3, 958, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1519, '330401', '330400', '市辖区', 3, 959, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1521, '330402', '330400', '南湖区', 3, 960, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1523, '330411', '330400', '秀洲区', 3, 961, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1525, '330421', '330400', '嘉善县', 3, 962, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1527, '330424', '330400', '海盐县', 3, 963, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1529, '330481', '330400', '海宁市', 3, 964, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1531, '330482', '330400', '平湖市', 3, 965, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1533, '330483', '330400', '桐乡市', 3, 966, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1535, '330501', '330500', '市辖区', 3, 967, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1537, '330502', '330500', '吴兴区', 3, 968, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1539, '330503', '330500', '南浔区', 3, 969, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1541, '330521', '330500', '德清县', 3, 970, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1543, '330522', '330500', '长兴县', 3, 971, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1545, '330523', '330500', '安吉县', 3, 972, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1547, '330601', '330600', '市辖区', 3, 973, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1549, '330602', '330600', '越城区', 3, 974, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1551, '330603', '330600', '柯桥区', 3, 975, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1553, '330624', '330600', '新昌县', 3, 977, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1555, '330681', '330600', '诸暨市', 3, 978, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1557, '330604', '330600', '上虞区', 3, 976, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1559, '330683', '330600', '嵊州市', 3, 979, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1561, '330701', '330700', '市辖区', 3, 980, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1563, '330702', '330700', '婺城区', 3, 981, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1565, '330703', '330700', '金东区', 3, 982, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1567, '330723', '330700', '武义县', 3, 983, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1569, '330726', '330700', '浦江县', 3, 984, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1571, '330727', '330700', '磐安县', 3, 985, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1573, '330781', '330700', '兰溪市', 3, 986, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1575, '330782', '330700', '义乌市', 3, 987, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1577, '330783', '330700', '东阳市', 3, 988, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1579, '330784', '330700', '永康市', 3, 989, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1581, '330801', '330800', '市辖区', 3, 990, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1583, '330802', '330800', '柯城区', 3, 991, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1585, '330803', '330800', '衢江区', 3, 992, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1587, '330822', '330800', '常山县', 3, 993, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1589, '330824', '330800', '开化县', 3, 994, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1591, '330825', '330800', '龙游县', 3, 995, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1593, '330881', '330800', '江山市', 3, 996, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1595, '330901', '330900', '市辖区', 3, 997, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1597, '330902', '330900', '定海区', 3, 998, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1599, '330903', '330900', '普陀区', 3, 999, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1601, '330921', '330900', '岱山县', 3, 1000, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1603, '330922', '330900', '嵊泗县', 3, 1001, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1605, '331001', '331000', '市辖区', 3, 1002, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1607, '331002', '331000', '椒江区', 3, 1003, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1609, '331003', '331000', '黄岩区', 3, 1004, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1611, '331004', '331000', '路桥区', 3, 1005, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1613, '331021', '331000', '玉环县', 3, 1006, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1615, '331022', '331000', '三门县', 3, 1007, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1617, '331023', '331000', '天台县', 3, 1008, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1619, '331024', '331000', '仙居县', 3, 1009, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1621, '331081', '331000', '温岭市', 3, 1010, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1623, '331082', '331000', '临海市', 3, 1011, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1625, '331101', '331100', '市辖区', 3, 1012, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1627, '331102', '331100', '莲都区', 3, 1013, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1629, '331121', '331100', '青田县', 3, 1014, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1631, '331122', '331100', '缙云县', 3, 1015, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1633, '331123', '331100', '遂昌县', 3, 1016, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1635, '331124', '331100', '松阳县', 3, 1017, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1637, '410425', '410400', '郏县', 3, 1553, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1639, '410481', '410400', '舞钢市', 3, 1554, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1641, '410482', '410400', '汝州市', 3, 1555, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1643, '410501', '410500', '市辖区', 3, 1556, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1645, '410502', '410500', '文峰区', 3, 1557, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1647, '410503', '410500', '北关区', 3, 1558, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1649, '410505', '410500', '殷都区', 3, 1559, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1651, '410506', '410500', '龙安区', 3, 1560, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1653, '410522', '410500', '安阳县', 3, 1561, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1655, '410523', '410500', '汤阴县', 3, 1562, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1657, '410526', '410500', '滑县', 3, 1563, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1659, '410527', '410500', '内黄县', 3, 1564, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1661, '410581', '410500', '林州市', 3, 1565, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1663, '410601', '410600', '市辖区', 3, 1566, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1665, '410602', '410600', '鹤山区', 3, 1567, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1667, '410603', '410600', '山城区', 3, 1568, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1669, '410611', '410600', '淇滨区', 3, 1569, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1671, '410621', '410600', '浚县', 3, 1570, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1673, '410622', '410600', '淇县', 3, 1571, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1675, '410701', '410700', '市辖区', 3, 1572, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1677, '410702', '410700', '红旗区', 3, 1573, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1679, '410703', '410700', '卫滨区', 3, 1574, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1681, '410704', '410700', '凤泉区', 3, 1575, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1683, '410711', '410700', '牧野区', 3, 1576, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1685, '410721', '410700', '新乡县', 3, 1577, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1687, '410724', '410700', '获嘉县', 3, 1578, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1689, '410725', '410700', '原阳县', 3, 1579, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1691, '510701', '510700', '市辖区', 3, 2306, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1693, '510703', '510700', '涪城区', 3, 2307, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1695, '510704', '510700', '游仙区', 3, 2308, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1697, '510722', '510700', '三台县', 3, 2309, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1699, '510723', '510700', '盐亭县', 3, 2310, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1701, '510725', '510700', '梓潼县', 3, 2312, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1703, '510726', '510700', '北川羌族自治县', 3, 2313, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1705, '510727', '510700', '平武县', 3, 2314, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1707, '510781', '510700', '江油市', 3, 2315, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1709, '510801', '510800', '市辖区', 3, 2316, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1711, '510802', '510800', '利州区', 3, 2317, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1713, '510811', '510800', '昭化区', 3, 2318, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1715, '510812', '510800', '朝天区', 3, 2319, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1717, '510821', '510800', '旺苍县', 3, 2320, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1719, '510822', '510800', '青川县', 3, 2321, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1721, '510823', '510800', '剑阁县', 3, 2322, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1723, '510824', '510800', '苍溪县', 3, 2323, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1725, '510901', '510900', '市辖区', 3, 2324, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1727, '510903', '510900', '船山区', 3, 2325, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1729, '510904', '510900', '安居区', 3, 2326, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1731, '510921', '510900', '蓬溪县', 3, 2327, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1733, '510922', '510900', '射洪县', 3, 2328, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1735, '510923', '510900', '大英县', 3, 2329, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1737, '511001', '511000', '市辖区', 3, 2330, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1739, '511002', '511000', '市中区', 3, 2331, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1741, '511011', '511000', '东兴区', 3, 2332, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1743, '511024', '511000', '威远县', 3, 2333, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1745, '511025', '511000', '资中县', 3, 2334, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1747, '511028', '511000', '隆昌县', 3, 2335, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1749, '511101', '511100', '市辖区', 3, 2336, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1751, '511102', '511100', '市中区', 3, 2337, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1753, '511111', '511100', '沙湾区', 3, 2338, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1755, '511112', '511100', '五通桥区', 3, 2339, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1757, '511113', '511100', '金口河区', 3, 2340, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1759, '511123', '511100', '犍为县', 3, 2341, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1761, '511124', '511100', '井研县', 3, 2342, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1763, '511126', '511100', '夹江县', 3, 2343, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1765, '511129', '511100', '沐川县', 3, 2344, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1767, '511132', '511100', '峨边彝族自治县', 3, 2345, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1769, '511133', '511100', '马边彝族自治县', 3, 2346, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1771, '511181', '511100', '峨眉山市', 3, 2347, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1773, '511301', '511300', '市辖区', 3, 2348, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1775, '511302', '511300', '顺庆区', 3, 2349, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1777, '511303', '511300', '高坪区', 3, 2350, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1779, '511304', '511300', '嘉陵区', 3, 2351, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1781, '511321', '511300', '南部县', 3, 2352, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1783, '511322', '511300', '营山县', 3, 2353, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1785, '511323', '511300', '蓬安县', 3, 2354, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1787, '511324', '511300', '仪陇县', 3, 2355, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1789, '511325', '511300', '西充县', 3, 2356, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1791, '511381', '511300', '阆中市', 3, 2357, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1793, '511401', '511400', '市辖区', 3, 2358, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1795, '511402', '511400', '东坡区', 3, 2359, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1797, '511421', '511400', '仁寿县', 3, 2361, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1799, '511403', '511400', '彭山区', 3, 2360, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1801, '511423', '511400', '洪雅县', 3, 2362, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1803, '511424', '511400', '丹棱县', 3, 2363, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1805, '511425', '511400', '青神县', 3, 2364, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1807, '511501', '511500', '市辖区', 3, 2365, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1809, '511502', '511500', '翠屏区', 3, 2366, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1811, '511521', '511500', '宜宾县', 3, 2368, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1813, '511503', '511500', '南溪区', 3, 2367, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1815, '511523', '511500', '江安县', 3, 2369, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1817, '511524', '511500', '长宁县', 3, 2370, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1819, '511525', '511500', '高县', 3, 2371, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1821, '511526', '511500', '珙县', 3, 2372, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1823, '511527', '511500', '筠连县', 3, 2373, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1825, '511528', '511500', '兴文县', 3, 2374, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1827, '511529', '511500', '屏山县', 3, 2375, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1829, '230223', '230200', '依安县', 3, 670, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1831, '230224', '230200', '泰来县', 3, 671, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1833, '230225', '230200', '甘南县', 3, 672, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1835, '230227', '230200', '富裕县', 3, 673, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1837, '230229', '230200', '克山县', 3, 674, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1839, '230230', '230200', '克东县', 3, 675, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1841, '230231', '230200', '拜泉县', 3, 676, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1843, '230281', '230200', '讷河市', 3, 677, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1845, '230301', '230300', '市辖区', 3, 678, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1847, '230302', '230300', '鸡冠区', 3, 679, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1849, '230303', '230300', '恒山区', 3, 680, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1851, '230304', '230300', '滴道区', 3, 681, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1853, '230305', '230300', '梨树区', 3, 682, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1855, '230306', '230300', '城子河区', 3, 683, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1857, '230307', '230300', '麻山区', 3, 684, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1859, '230321', '230300', '鸡东县', 3, 685, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1861, '230381', '230300', '虎林市', 3, 686, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1863, '230382', '230300', '密山市', 3, 687, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1865, '230401', '230400', '市辖区', 3, 688, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1867, '320706', '320700', '海州区', 3, 869, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1869, '320707', '320700', '赣榆区', 3, 870, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1871, '320722', '320700', '东海县', 3, 871, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1873, '320723', '320700', '灌云县', 3, 872, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1875, '320724', '320700', '灌南县', 3, 873, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1877, '320801', '320800', '市辖区', 3, 874, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1879, '320802', '320800', '清河区', 3, 875, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1881, '320803', '320800', '淮安区', 3, 876, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1883, '320804', '320800', '淮阴区', 3, 877, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1885, '320826', '320800', '涟水县', 3, 879, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1887, '320830', '320800', '盱眙县', 3, 881, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1889, '320831', '320800', '金湖县', 3, 882, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1891, '320901', '320900', '市辖区', 3, 883, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1893, '320902', '320900', '亭湖区', 3, 884, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1895, '320903', '320900', '盐都区', 3, 885, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1897, '320921', '320900', '响水县', 3, 887, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1899, '320922', '320900', '滨海县', 3, 888, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1901, '320923', '320900', '阜宁县', 3, 889, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1903, '320924', '320900', '射阳县', 3, 890, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1905, '320925', '320900', '建湖县', 3, 891, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1907, '320981', '320900', '东台市', 3, 892, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1909, '320904', '320900', '大丰区', 3, 886, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1911, '321001', '321000', '市辖区', 3, 893, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1913, '321002', '321000', '广陵区', 3, 894, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1915, '321003', '321000', '邗江区', 3, 895, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1917, '321023', '321000', '宝应县', 3, 897, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1919, '321081', '321000', '仪征市', 3, 898, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1921, '321084', '321000', '高邮市', 3, 899, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1923, '321012', '321000', '江都区', 3, 896, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1925, '321101', '321100', '市辖区', 3, 901, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1927, '321102', '321100', '京口区', 3, 902, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1929, '321111', '321100', '润州区', 3, 903, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1931, '321112', '321100', '丹徒区', 3, 904, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1933, '321181', '321100', '丹阳市', 3, 905, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1935, '321182', '321100', '扬中市', 3, 906, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1937, '321183', '321100', '句容市', 3, 907, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1939, '321201', '321200', '市辖区', 3, 908, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1941, '321202', '321200', '海陵区', 3, 909, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1943, '321203', '321200', '高港区', 3, 910, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1945, '321281', '321200', '兴化市', 3, 912, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1947, '321282', '321200', '靖江市', 3, 913, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1949, '321283', '321200', '泰兴市', 3, 914, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1951, '321204', '321200', '姜堰区', 3, 911, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1953, '321301', '321300', '市辖区', 3, 915, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1955, '321302', '321300', '宿城区', 3, 916, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1957, '321311', '321300', '宿豫区', 3, 917, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1959, '321322', '321300', '沭阳县', 3, 918, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1961, '321323', '321300', '泗阳县', 3, 919, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1963, '321324', '321300', '泗洪县', 3, 920, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1965, '330101', '330100', '市辖区', 3, 921, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1967, '330102', '330100', '上城区', 3, 922, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1969, '330103', '330100', '下城区', 3, 923, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1971, '330104', '330100', '江干区', 3, 924, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1973, '330105', '330100', '拱墅区', 3, 925, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1975, '330106', '330100', '西湖区', 3, 926, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1977, '330108', '330100', '滨江区', 3, 927, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1979, '330109', '330100', '萧山区', 3, 928, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1981, '330110', '330100', '余杭区', 3, 929, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1983, '330122', '330100', '桐庐县', 3, 931, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1985, '330127', '330100', '淳安县', 3, 932, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1987, '330182', '330100', '建德市', 3, 933, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1989, '330111', '330100', '富阳区', 3, 930, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1991, '330185', '330100', '临安市', 3, 934, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1993, '330201', '330200', '市辖区', 3, 935, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1995, '330203', '330200', '海曙区', 3, 936, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1997, '330204', '330200', '江东区', 3, 937, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (1999, '330205', '330200', '江北区', 3, 938, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2001, '330206', '330200', '北仑区', 3, 939, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2003, '330211', '330200', '镇海区', 3, 940, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2005, '330212', '330200', '鄞州区', 3, 941, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2007, '330225', '330200', '象山县', 3, 942, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2009, '330226', '330200', '宁海县', 3, 943, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2011, '330281', '330200', '余姚市', 3, 944, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2013, '330282', '330200', '慈溪市', 3, 945, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2015, '330283', '330200', '奉化市', 3, 946, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2017, '330301', '330300', '市辖区', 3, 947, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2019, '330302', '330300', '鹿城区', 3, 948, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2021, '330303', '330300', '龙湾区', 3, 949, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2023, '330304', '330300', '瓯海区', 3, 950, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2025, '330305', '330300', '洞头区', 3, 951, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2027, '330324', '330300', '永嘉县', 3, 952, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2029, '330326', '330300', '平阳县', 3, 953, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2031, '330327', '330300', '苍南县', 3, 954, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2033, '330328', '330300', '文成县', 3, 955, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2035, '330329', '330300', '泰顺县', 3, 956, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2037, '450681', '450600', '东兴市', 3, 2129, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2039, '450701', '450700', '市辖区', 3, 2130, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2041, '450702', '450700', '钦南区', 3, 2131, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2043, '450703', '450700', '钦北区', 3, 2132, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2045, '450721', '450700', '灵山县', 3, 2133, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2047, '450722', '450700', '浦北县', 3, 2134, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2049, '450801', '450800', '市辖区', 3, 2135, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2051, '450802', '450800', '港北区', 3, 2136, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2053, '450803', '450800', '港南区', 3, 2137, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2055, '450804', '450800', '覃塘区', 3, 2138, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2057, '450821', '450800', '平南县', 3, 2139, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2059, '450881', '450800', '桂平市', 3, 2140, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2061, '450901', '450900', '市辖区', 3, 2141, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2063, '450902', '450900', '玉州区', 3, 2142, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2065, '450921', '450900', '容县', 3, 2144, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2067, '450922', '450900', '陆川县', 3, 2145, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2069, '450923', '450900', '博白县', 3, 2146, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2071, '450924', '450900', '兴业县', 3, 2147, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2073, '450981', '450900', '北流市', 3, 2148, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2075, '451001', '451000', '市辖区', 3, 2148, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2077, '451002', '451000', '右江区', 3, 2149, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2079, '451021', '451000', '田阳县', 3, 2150, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2081, '451022', '451000', '田东县', 3, 2151, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2083, '451023', '451000', '平果县', 3, 2152, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2085, '451024', '451000', '德保县', 3, 2153, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2087, '451081', '451000', '靖西市', 3, 2161, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2089, '451026', '451000', '那坡县', 3, 2155, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2091, '451027', '451000', '凌云县', 3, 2156, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2093, '451028', '451000', '乐业县', 3, 2157, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2095, '451029', '451000', '田林县', 3, 2158, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2097, '451030', '451000', '西林县', 3, 2159, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2099, '451031', '451000', '隆林各族自治县', 3, 2160, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2101, '451101', '451100', '市辖区', 3, 2161, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2103, '451102', '451100', '八步区', 3, 2162, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2105, '451121', '451100', '昭平县', 3, 2163, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2107, '451122', '451100', '钟山县', 3, 2164, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2109, '451123', '451100', '富川瑶族自治县', 3, 2165, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2111, '451201', '451200', '市辖区', 3, 2166, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2113, '451202', '451200', '金城江区', 3, 2167, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2115, '451221', '451200', '南丹县', 3, 2168, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2117, '451222', '451200', '天峨县', 3, 2169, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2119, '451223', '451200', '凤山县', 3, 2170, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2121, '451224', '451200', '东兰县', 3, 2171, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2123, '451225', '451200', '罗城仫佬族自治县', 3, 2172, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2125, '451226', '451200', '环江毛南族自治县', 3, 2173, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2127, '451227', '451200', '巴马瑶族自治县', 3, 2174, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2129, '451228', '451200', '都安瑶族自治县', 3, 2175, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2131, '451229', '451200', '大化瑶族自治县', 3, 2176, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2133, '451281', '451200', '宜州市', 3, 2177, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2135, '451301', '451300', '市辖区', 3, 2178, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2137, '451302', '451300', '兴宾区', 3, 2179, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2139, '451321', '451300', '忻城县', 3, 2180, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2141, '451322', '451300', '象州县', 3, 2181, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2143, '451323', '451300', '武宣县', 3, 2182, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2145, '451324', '451300', '金秀瑶族自治县', 3, 2183, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2147, '451381', '451300', '合山市', 3, 2184, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2149, '451401', '451400', '市辖区', 3, 2185, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2151, '451402', '451400', '江州区', 3, 2186, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2153, '451421', '451400', '扶绥县', 3, 2187, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2155, '451422', '451400', '宁明县', 3, 2188, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2157, '451423', '451400', '龙州县', 3, 2189, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2159, '451424', '451400', '大新县', 3, 2190, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2161, '451425', '451400', '天等县', 3, 2191, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2163, '451481', '451400', '凭祥市', 3, 2192, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2165, '460101', '460100', '市辖区', 3, 2193, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2167, '460105', '460100', '秀英区', 3, 2194, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2169, '460106', '460100', '龙华区', 3, 2195, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2171, '460107', '460100', '琼山区', 3, 2196, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2173, '460108', '460100', '美兰区', 3, 2197, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2175, '460201', '460200', '市辖区', 3, 2198, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2177, '469001', '469000', '五指山市', 3, 2199, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2179, '469002', '469000', '琼海市', 3, 2200, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2181, '469003', '469000', '儋州市', 3, 2201, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2183, '469005', '469000', '文昌市', 3, 2202, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2185, '469006', '469000', '万宁市', 3, 2203, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2187, '469007', '469000', '东方市', 3, 2204, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2189, '469021', '469000', '定安县', 3, 2205, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2191, '469022', '469000', '屯昌县', 3, 2206, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2193, '469023', '469000', '澄迈县', 3, 2207, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2195, '469024', '469000', '临高县', 3, 2208, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2197, '469025', '469000', '白沙黎族自治县', 3, 2209, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2199, '469026', '469000', '昌江黎族自治县', 3, 2210, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2201, '469027', '469000', '乐东黎族自治县', 3, 2211, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2203, '469028', '469000', '陵水黎族自治县', 3, 2212, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2205, '469029', '469000', '保亭黎族苗族自治县', 3, 2213, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2207, '469030', '469000', '琼中黎族苗族自治县', 3, 2214, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2209, '540101', '540100', '市辖区', 3, 2685, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2211, '540102', '540100', '城关区', 3, 2686, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2213, '540121', '540100', '林周县', 3, 2687, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2215, '540122', '540100', '当雄县', 3, 2688, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2217, '540123', '540100', '尼木县', 3, 2689, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2219, '540124', '540100', '曲水县', 3, 2690, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2221, '540126', '540100', '达孜县', 3, 2692, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2223, '540127', '540100', '墨竹工卡县', 3, 2693, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2225, '540302', '540300', '卡若区', 3, 2694, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2227, '540321', '540300', '江达县', 3, 2695, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2229, '540322', '540300', '贡觉县', 3, 2696, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2231, '540323', '540300', '类乌齐县', 3, 2697, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2233, '540324', '540300', '丁青县', 3, 2698, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2235, '540325', '540300', '察雅县', 3, 2699, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2237, '540326', '540300', '八宿县', 3, 2700, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2239, '540327', '540300', '左贡县', 3, 2701, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2241, '540328', '540300', '芒康县', 3, 2702, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2243, '540329', '540300', '洛隆县', 3, 2703, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2245, '540330', '540300', '边坝县', 3, 2704, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2247, '540202', '540200', '桑珠孜区', 3, 2717, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2249, '540221', '540200', '南木林县', 3, 2718, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2251, '540222', '540200', '江孜县', 3, 2719, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2253, '540223', '540200', '定日县', 3, 2720, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2255, '540224', '540200', '萨迦县', 3, 2721, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2257, '540225', '540200', '拉孜县', 3, 2722, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2259, '540226', '540200', '昂仁县', 3, 2723, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2261, '540227', '540200', '谢通门县', 3, 2724, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2263, '540228', '540200', '白朗县', 3, 2725, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2265, '540229', '540200', '仁布县', 3, 2726, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2267, '540230', '540200', '康马县', 3, 2727, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2269, '540231', '540200', '定结县', 3, 2728, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2271, '540232', '540200', '仲巴县', 3, 2729, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2273, '540233', '540200', '亚东县', 3, 2730, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2275, '540234', '540200', '吉隆县', 3, 2731, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2277, '540235', '540200', '聂拉木县', 3, 2732, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2279, '540236', '540200', '萨嘎县', 3, 2733, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2281, '540237', '540200', '岗巴县', 3, 2734, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2283, '542421', '542400', '那曲县', 3, 2735, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2285, '542422', '542400', '嘉黎县', 3, 2736, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2287, '542423', '542400', '比如县', 3, 2737, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2289, '542424', '542400', '聂荣县', 3, 2738, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2291, '542425', '542400', '安多县', 3, 2739, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2293, '542426', '542400', '申扎县', 3, 2740, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2295, '542427', '542400', '索县', 3, 2741, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2297, '542428', '542400', '班戈县', 3, 2742, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2299, '542429', '542400', '巴青县', 3, 2743, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2301, '542430', '542400', '尼玛县', 3, 2744, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2303, '542521', '542500', '普兰县', 3, 2745, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2305, '542522', '542500', '札达县', 3, 2746, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2307, '542523', '542500', '噶尔县', 3, 2747, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2309, '542524', '542500', '日土县', 3, 2748, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2311, '542525', '542500', '革吉县', 3, 2749, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2313, '542526', '542500', '改则县', 3, 2750, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2315, '542527', '542500', '措勤县', 3, 2751, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2317, '540402', '540400', '巴宜区', 3, 2752, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2319, '540421', '540400', '工布江达县', 3, 2753, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2321, '540422', '540400', '米林县', 3, 2754, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2323, '540423', '540400', '墨脱县', 3, 2755, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2325, '540424', '540400', '波密县', 3, 2756, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2327, '540425', '540400', '察隅县', 3, 2757, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2329, '540426', '540400', '朗县', 3, 2758, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2331, '610101', '610100', '市辖区', 3, 2759, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2333, '610102', '610100', '新城区', 3, 2760, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2335, '610103', '610100', '碑林区', 3, 2761, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2337, '610104', '610100', '莲湖区', 3, 2762, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2339, '610111', '610100', '灞桥区', 3, 2763, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2341, '610112', '610100', '未央区', 3, 2764, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2343, '610113', '610100', '雁塔区', 3, 2765, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2345, '610114', '610100', '阎良区', 3, 2766, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2347, '610115', '610100', '临潼区', 3, 2767, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2349, '610116', '610100', '长安区', 3, 2768, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2351, '610122', '610100', '蓝田县', 3, 2770, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2353, '610124', '610100', '周至县', 3, 2771, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2355, '610125', '610100', '户县', 3, 2772, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2357, '610117', '610100', '高陵区', 3, 2769, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2359, '610201', '610200', '市辖区', 3, 2773, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2361, '610202', '610200', '王益区', 3, 2774, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2363, '610203', '610200', '印台区', 3, 2775, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2365, '610204', '610200', '耀州区', 3, 2776, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2367, '610222', '610200', '宜君县', 3, 2777, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2369, '610301', '610300', '市辖区', 3, 2778, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2371, '610302', '610300', '渭滨区', 3, 2779, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2373, '610303', '610300', '金台区', 3, 2780, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2375, '610304', '610300', '陈仓区', 3, 2781, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2377, '610322', '610300', '凤翔县', 3, 2782, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2379, '610323', '610300', '岐山县', 3, 2783, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2381, '610324', '610300', '扶风县', 3, 2784, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2383, '610326', '610300', '眉县', 3, 2785, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2385, '610327', '610300', '陇县', 3, 2786, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2387, '610328', '610300', '千阳县', 3, 2787, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2389, '610329', '610300', '麟游县', 3, 2788, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2391, '610330', '610300', '凤县', 3, 2789, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2393, '610331', '610300', '太白县', 3, 2790, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2395, '610401', '610400', '市辖区', 3, 2791, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2397, '610402', '610400', '秦都区', 3, 2792, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2399, '610403', '610400', '杨陵区', 3, 2793, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2401, '610404', '610400', '渭城区', 3, 2794, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2403, '610422', '610400', '三原县', 3, 2795, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2405, '610423', '610400', '泾阳县', 3, 2796, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2407, '610424', '610400', '乾县', 3, 2797, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2409, '610425', '610400', '礼泉县', 3, 2798, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2411, '610426', '610400', '永寿县', 3, 2799, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2413, '610427', '610400', '彬县', 3, 2800, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2415, '610428', '610400', '长武县', 3, 2801, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2417, '610429', '610400', '旬邑县', 3, 2802, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2419, '610430', '610400', '淳化县', 3, 2803, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2421, '610431', '610400', '武功县', 3, 2804, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2423, '610481', '610400', '兴平市', 3, 2805, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2425, '610501', '610500', '市辖区', 3, 2806, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2427, '610502', '610500', '临渭区', 3, 2807, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2429, '610522', '610500', '潼关县', 3, 2809, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2431, '610523', '610500', '大荔县', 3, 2810, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2433, '610524', '610500', '合阳县', 3, 2811, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2435, '610525', '610500', '澄城县', 3, 2812, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2437, '610526', '610500', '蒲城县', 3, 2813, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2439, '610527', '610500', '白水县', 3, 2814, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2441, '610528', '610500', '富平县', 3, 2815, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2443, '610581', '610500', '韩城市', 3, 2816, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2445, '610582', '610500', '华阴市', 3, 2817, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2447, '610601', '610600', '市辖区', 3, 2818, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2449, '610621', '610600', '延长县', 3, 2820, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2451, '610622', '610600', '延川县', 3, 2821, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2453, '610623', '610600', '子长县', 3, 2822, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2455, '610625', '610600', '志丹县', 3, 2824, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2457, '610626', '610600', '吴起县', 3, 2825, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2459, '610627', '610600', '甘泉县', 3, 2826, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2461, '610628', '610600', '富县', 3, 2827, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2463, '610629', '610600', '洛川县', 3, 2828, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2465, '610630', '610600', '宜川县', 3, 2829, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2467, '610631', '610600', '黄龙县', 3, 2830, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2469, '610632', '610600', '黄陵县', 3, 2831, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2471, '610701', '610700', '市辖区', 3, 2832, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2473, '610702', '610700', '汉台区', 3, 2833, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2475, '610721', '610700', '南郑县', 3, 2834, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2477, '610722', '610700', '城固县', 3, 2835, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2479, '610723', '610700', '洋县', 3, 2836, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2481, '610724', '610700', '西乡县', 3, 2837, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2483, '610725', '610700', '勉县', 3, 2838, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2485, '610726', '610700', '宁强县', 3, 2839, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2487, '610727', '610700', '略阳县', 3, 2840, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2489, '610728', '610700', '镇巴县', 3, 2841, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2491, '610729', '610700', '留坝县', 3, 2842, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2493, '610730', '610700', '佛坪县', 3, 2843, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2495, '610801', '610800', '市辖区', 3, 2844, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2497, '610802', '610800', '榆阳区', 3, 2845, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2499, '610821', '610800', '神木县', 3, 2846, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2501, '610822', '610800', '府谷县', 3, 2847, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2503, '610824', '610800', '靖边县', 3, 2849, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2505, '610825', '610800', '定边县', 3, 2850, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2507, '610826', '610800', '绥德县', 3, 2851, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2509, '610827', '610800', '米脂县', 3, 2852, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2511, '610828', '610800', '佳县', 3, 2853, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2513, '610829', '610800', '吴堡县', 3, 2854, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2515, '610830', '610800', '清涧县', 3, 2855, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2517, '610831', '610800', '子洲县', 3, 2856, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2519, '610901', '610900', '市辖区', 3, 2857, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2521, '610902', '610900', '汉滨区', 3, 2858, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2523, '610921', '610900', '汉阴县', 3, 2859, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2525, '610922', '610900', '石泉县', 3, 2860, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2527, '610923', '610900', '宁陕县', 3, 2861, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2529, '610924', '610900', '紫阳县', 3, 2862, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2531, '610925', '610900', '岚皋县', 3, 2863, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2533, '410726', '410700', '延津县', 3, 1580, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2535, '410727', '410700', '封丘县', 3, 1581, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2537, '410728', '410700', '长垣县', 3, 1582, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2539, '410781', '410700', '卫辉市', 3, 1583, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2541, '410782', '410700', '辉县市', 3, 1584, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2543, '410801', '410800', '市辖区', 3, 1585, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2545, '410802', '410800', '解放区', 3, 1586, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2547, '410803', '410800', '中站区', 3, 1587, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2549, '410804', '410800', '马村区', 3, 1588, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2551, '410811', '410800', '山阳区', 3, 1589, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2553, '410821', '410800', '修武县', 3, 1590, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2555, '410822', '410800', '博爱县', 3, 1591, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2557, '410823', '410800', '武陟县', 3, 1592, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2559, '410825', '410800', '温县', 3, 1593, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2561, '410882', '410800', '沁阳市', 3, 1595, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2563, '410883', '410800', '孟州市', 3, 1596, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2565, '410901', '410900', '市辖区', 3, 1597, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2567, '410902', '410900', '华龙区', 3, 1598, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2569, '410922', '410900', '清丰县', 3, 1599, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2571, '410923', '410900', '南乐县', 3, 1600, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2573, '410926', '410900', '范县', 3, 1601, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2575, '410927', '410900', '台前县', 3, 1602, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2577, '410928', '410900', '濮阳县', 3, 1603, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2579, '411001', '411000', '市辖区', 3, 1604, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2581, '411002', '411000', '魏都区', 3, 1605, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2583, '411023', '411000', '许昌县', 3, 1606, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2585, '411024', '411000', '鄢陵县', 3, 1607, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2587, '411025', '411000', '襄城县', 3, 1608, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2589, '411081', '411000', '禹州市', 3, 1609, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2591, '411082', '411000', '长葛市', 3, 1610, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2593, '411101', '411100', '市辖区', 3, 1611, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2595, '411102', '411100', '源汇区', 3, 1612, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2597, '411103', '411100', '郾城区', 3, 1613, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2599, '411104', '411100', '召陵区', 3, 1614, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2601, '411121', '411100', '舞阳县', 3, 1615, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2603, '411122', '411100', '临颍县', 3, 1616, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2605, '411201', '411200', '市辖区', 3, 1617, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2607, '411202', '411200', '湖滨区', 3, 1618, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2609, '411221', '411200', '渑池县', 3, 1619, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2611, '411224', '411200', '卢氏县', 3, 1621, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2613, '411281', '411200', '义马市', 3, 1622, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2615, '411282', '411200', '灵宝市', 3, 1623, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2617, '411301', '411300', '市辖区', 3, 1624, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2619, '411302', '411300', '宛城区', 3, 1625, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2621, '411303', '411300', '卧龙区', 3, 1626, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2623, '411321', '411300', '南召县', 3, 1627, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2625, '411322', '411300', '方城县', 3, 1628, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2627, '411323', '411300', '西峡县', 3, 1629, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2629, '411324', '411300', '镇平县', 3, 1630, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2631, '411325', '411300', '内乡县', 3, 1631, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2633, '411326', '411300', '淅川县', 3, 1632, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2635, '411327', '411300', '社旗县', 3, 1633, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2637, '411328', '411300', '唐河县', 3, 1634, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2639, '411329', '411300', '新野县', 3, 1635, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2641, '411330', '411300', '桐柏县', 3, 1636, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2643, '411381', '411300', '邓州市', 3, 1637, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2645, '411401', '411400', '市辖区', 3, 1638, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2647, '411402', '411400', '梁园区', 3, 1639, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2649, '411403', '411400', '睢阳区', 3, 1640, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2651, '411421', '411400', '民权县', 3, 1641, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2653, '411422', '411400', '睢县', 3, 1642, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2655, '411423', '411400', '宁陵县', 3, 1643, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2657, '411424', '411400', '柘城县', 3, 1644, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2659, '411425', '411400', '虞城县', 3, 1645, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2661, '411426', '411400', '夏邑县', 3, 1646, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2663, '411481', '411400', '永城市', 3, 1647, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2665, '411501', '411500', '市辖区', 3, 1648, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2667, '411502', '411500', '浉河区', 3, 1649, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2669, '411503', '411500', '平桥区', 3, 1650, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2671, '411521', '411500', '罗山县', 3, 1651, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2673, '411522', '411500', '光山县', 3, 1652, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2675, '411523', '411500', '新县', 3, 1653, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2677, '411524', '411500', '商城县', 3, 1654, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2679, '411525', '411500', '固始县', 3, 1655, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2681, '411526', '411500', '潢川县', 3, 1656, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2683, '411527', '411500', '淮滨县', 3, 1657, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2685, '411528', '411500', '息县', 3, 1658, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2687, '411601', '411600', '市辖区', 3, 1659, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2689, '411602', '411600', '川汇区', 3, 1660, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2691, '411621', '411600', '扶沟县', 3, 1661, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2693, '411622', '411600', '西华县', 3, 1662, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2695, '411623', '411600', '商水县', 3, 1663, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2697, '411624', '411600', '沈丘县', 3, 1664, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2699, '411625', '411600', '郸城县', 3, 1665, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2701, '411626', '411600', '淮阳县', 3, 1666, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2703, '411627', '411600', '太康县', 3, 1667, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2705, '411628', '411600', '鹿邑县', 3, 1668, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2707, '411681', '411600', '项城市', 3, 1669, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2709, '411701', '411700', '市辖区', 3, 1670, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2711, '411702', '411700', '驿城区', 3, 1671, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2713, '411721', '411700', '西平县', 3, 1672, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2715, '411722', '411700', '上蔡县', 3, 1673, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2717, '411723', '411700', '平舆县', 3, 1674, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2719, '411724', '411700', '正阳县', 3, 1675, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2721, '411725', '411700', '确山县', 3, 1676, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2723, '411726', '411700', '泌阳县', 3, 1677, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2725, '411727', '411700', '汝南县', 3, 1678, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2727, '411728', '411700', '遂平县', 3, 1679, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2729, '411729', '411700', '新蔡县', 3, 1680, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2731, '420101', '420100', '市辖区', 3, 1681, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2733, '420102', '420100', '江岸区', 3, 1682, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2735, '420103', '420100', '江汉区', 3, 1683, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2737, '420104', '420100', '硚口区', 3, 1684, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2739, '420105', '420100', '汉阳区', 3, 1685, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2741, '420106', '420100', '武昌区', 3, 1686, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2743, '420107', '420100', '青山区', 3, 1687, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2745, '420111', '420100', '洪山区', 3, 1688, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2747, '420112', '420100', '东西湖区', 3, 1689, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2749, '420113', '420100', '汉南区', 3, 1690, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2751, '420114', '420100', '蔡甸区', 3, 1691, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2753, '420115', '420100', '江夏区', 3, 1692, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2755, '420116', '420100', '黄陂区', 3, 1693, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2757, '420117', '420100', '新洲区', 3, 1694, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2759, '420201', '420200', '市辖区', 3, 1695, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2761, '420202', '420200', '黄石港区', 3, 1696, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2763, '420203', '420200', '西塞山区', 3, 1697, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2765, '420204', '420200', '下陆区', 3, 1698, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2767, '420205', '420200', '铁山区', 3, 1699, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2769, '420222', '420200', '阳新县', 3, 1700, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2771, '420281', '420200', '大冶市', 3, 1701, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2773, '420301', '420300', '市辖区', 3, 1702, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2775, '420302', '420300', '茅箭区', 3, 1703, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2777, '420303', '420300', '张湾区', 3, 1704, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2779, '420304', '420300', '郧阳区', 3, 1705, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2781, '420322', '420300', '郧西县', 3, 1706, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2783, '420323', '420300', '竹山县', 3, 1707, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2785, '420324', '420300', '竹溪县', 3, 1708, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2787, '420325', '420300', '房县', 3, 1709, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2789, '420381', '420300', '丹江口市', 3, 1710, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2791, '420501', '420500', '市辖区', 3, 1711, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2793, '420502', '420500', '西陵区', 3, 1712, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2795, '420503', '420500', '伍家岗区', 3, 1713, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2797, '420504', '420500', '点军区', 3, 1714, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2799, '420505', '420500', '猇亭区', 3, 1715, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2801, '420506', '420500', '夷陵区', 3, 1716, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2803, '420525', '420500', '远安县', 3, 1717, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2805, '420526', '420500', '兴山县', 3, 1718, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2807, '420527', '420500', '秭归县', 3, 1719, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2809, '420528', '420500', '长阳土家族自治县', 3, 1720, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2811, '420529', '420500', '五峰土家族自治县', 3, 1721, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2813, '420581', '420500', '宜都市', 3, 1722, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2815, '420582', '420500', '当阳市', 3, 1723, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2817, '420583', '420500', '枝江市', 3, 1724, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2819, '420601', '420600', '市辖区', 3, 1725, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2821, '511601', '511600', '市辖区', 3, 2376, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2823, '511602', '511600', '广安区', 3, 2377, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2825, '511621', '511600', '岳池县', 3, 2379, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2827, '511622', '511600', '武胜县', 3, 2380, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2829, '511623', '511600', '邻水县', 3, 2381, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2831, '511681', '511600', '华蓥市', 3, 2382, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2833, '511701', '511700', '市辖区', 3, 2382, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2835, '511702', '511700', '通川区', 3, 2383, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2837, '511703', '511700', '达州区', 3, 2384, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2839, '511722', '511700', '宣汉县', 3, 2385, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2841, '511723', '511700', '开江县', 3, 2386, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2843, '511724', '511700', '大竹县', 3, 2387, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2845, '511725', '511700', '渠县', 3, 2388, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2847, '511781', '511700', '万源市', 3, 2389, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2849, '511801', '511800', '市辖区', 3, 2390, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2851, '511802', '511800', '雨城区', 3, 2391, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2853, '511803', '511800', '名山区', 3, 2392, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2855, '511822', '511800', '荥经县', 3, 2393, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2857, '511823', '511800', '汉源县', 3, 2394, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2859, '511824', '511800', '石棉县', 3, 2395, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2861, '511825', '511800', '天全县', 3, 2396, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2863, '511826', '511800', '芦山县', 3, 2397, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2865, '511827', '511800', '宝兴县', 3, 2398, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2867, '511901', '511900', '市辖区', 3, 2399, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2869, '511902', '511900', '巴州区', 3, 2400, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2871, '511921', '511900', '通江县', 3, 2402, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2873, '511922', '511900', '南江县', 3, 2403, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2875, '511923', '511900', '平昌县', 3, 2404, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2877, '512001', '512000', '市辖区', 3, 2404, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2879, '512002', '512000', '雁江区', 3, 2405, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2881, '512021', '512000', '安岳县', 3, 2406, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2883, '512022', '512000', '乐至县', 3, 2407, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2885, '513221', '513200', '汶川县', 3, 2409, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2887, '513222', '513200', '理县', 3, 2410, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2889, '513223', '513200', '茂县', 3, 2411, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2891, '513224', '513200', '松潘县', 3, 2412, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2893, '513225', '513200', '九寨沟县', 3, 2413, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2895, '513226', '513200', '金川县', 3, 2414, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2897, '513227', '513200', '小金县', 3, 2415, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2899, '513228', '513200', '黑水县', 3, 2416, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2901, '513230', '513200', '壤塘县', 3, 2418, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2903, '513231', '513200', '阿坝县', 3, 2419, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2905, '513232', '513200', '若尔盖县', 3, 2420, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2907, '513233', '513200', '红原县', 3, 2421, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2909, '513301', '513300', '康定市', 3, 2422, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2911, '513322', '513300', '泸定县', 3, 2423, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2913, '513323', '513300', '丹巴县', 3, 2424, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2915, '513324', '513300', '九龙县', 3, 2425, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2917, '513325', '513300', '雅江县', 3, 2426, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2919, '513326', '513300', '道孚县', 3, 2427, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2921, '513327', '513300', '炉霍县', 3, 2428, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2923, '513328', '513300', '甘孜县', 3, 2429, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2925, '513329', '513300', '新龙县', 3, 2430, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2927, '513330', '513300', '德格县', 3, 2431, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2929, '513331', '513300', '白玉县', 3, 2432, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2931, '513332', '513300', '石渠县', 3, 2433, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2933, '513333', '513300', '色达县', 3, 2434, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2935, '513334', '513300', '理塘县', 3, 2435, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2937, '513335', '513300', '巴塘县', 3, 2436, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2939, '513336', '513300', '乡城县', 3, 2437, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2941, '513337', '513300', '稻城县', 3, 2438, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2943, '513338', '513300', '得荣县', 3, 2439, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2945, '513401', '513400', '西昌市', 3, 2440, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2947, '513422', '513400', '木里藏族自治县', 3, 2441, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2949, '513423', '513400', '盐源县', 3, 2442, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2951, '513424', '513400', '德昌县', 3, 2443, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2953, '513425', '513400', '会理县', 3, 2444, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2955, '513426', '513400', '会东县', 3, 2445, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2957, '513427', '513400', '宁南县', 3, 2446, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2959, '513428', '513400', '普格县', 3, 2447, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2961, '513429', '513400', '布拖县', 3, 2448, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2963, '513430', '513400', '金阳县', 3, 2449, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2965, '513431', '513400', '昭觉县', 3, 2450, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2967, '513432', '513400', '喜德县', 3, 2451, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2969, '513433', '513400', '冕宁县', 3, 2452, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2971, '513434', '513400', '越西县', 3, 2453, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2973, '513435', '513400', '甘洛县', 3, 2454, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2975, '513436', '513400', '美姑县', 3, 2455, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2977, '513437', '513400', '雷波县', 3, 2456, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2979, '520101', '520100', '市辖区', 3, 2457, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2981, '520102', '520100', '南明区', 3, 2458, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2983, '520103', '520100', '云岩区', 3, 2459, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2985, '520111', '520100', '花溪区', 3, 2460, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2987, '520112', '520100', '乌当区', 3, 2461, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2989, '520113', '520100', '白云区', 3, 2462, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2991, '520115', '520100', '观山湖区', 3, 2463, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2993, '520121', '520100', '开阳县', 3, 2464, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2995, '520122', '520100', '息烽县', 3, 2465, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2997, '520123', '520100', '修文县', 3, 2466, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (2999, '520181', '520100', '清镇市', 3, 2467, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3001, '520201', '520200', '钟山区', 3, 2468, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3003, '520203', '520200', '六枝特区', 3, 2469, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3005, '520221', '520200', '水城县', 3, 2470, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3007, '520222', '520200', '盘县', 3, 2471, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3009, '520301', '520300', '市辖区', 3, 2472, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3011, '520302', '520300', '红花岗区', 3, 2473, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3013, '520303', '520300', '汇川区', 3, 2474, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3015, '520322', '520300', '桐梓县', 3, 2476, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3017, '520323', '520300', '绥阳县', 3, 2477, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3019, '520324', '520300', '正安县', 3, 2478, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3021, '520325', '520300', '道真仡佬族苗族自治县', 3, 2479, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3023, '520326', '520300', '务川仡佬族苗族自治县', 3, 2480, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3025, '520327', '520300', '凤冈县', 3, 2481, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3027, '520328', '520300', '湄潭县', 3, 2482, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3029, '520329', '520300', '余庆县', 3, 2483, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3031, '520330', '520300', '习水县', 3, 2484, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3033, '520381', '520300', '赤水市', 3, 2485, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3035, '520382', '520300', '仁怀市', 3, 2486, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3037, '520401', '520400', '市辖区', 3, 2487, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3039, '520402', '520400', '西秀区', 3, 2488, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3041, '520403', '520400', '平坝区', 3, 2489, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3043, '520422', '520400', '普定县', 3, 2490, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3045, '520423', '520400', '镇宁布依族苗族自治县', 3, 2491, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3047, '520424', '520400', '关岭布依族苗族自治县', 3, 2492, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3049, '520425', '520400', '紫云苗族布依族自治县', 3, 2493, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3051, '520601', '520600', '市辖区', 3, 2494, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3053, '520602', '520600', '碧江区', 3, 2495, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3055, '530624', '530600', '大关县', 3, 2594, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3057, '530625', '530600', '永善县', 3, 2595, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3059, '530626', '530600', '绥江县', 3, 2596, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3061, '530627', '530600', '镇雄县', 3, 2597, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3063, '530628', '530600', '彝良县', 3, 2598, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3065, '530629', '530600', '威信县', 3, 2599, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3067, '530630', '530600', '水富县', 3, 2600, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3069, '530701', '530700', '市辖区', 3, 2601, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3071, '530702', '530700', '古城区', 3, 2602, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3073, '530721', '530700', '玉龙纳西族自治县', 3, 2603, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3075, '530722', '530700', '永胜县', 3, 2604, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3077, '530723', '530700', '华坪县', 3, 2605, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3079, '530724', '530700', '宁蒗彝族自治县', 3, 2606, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3081, '530801', '530800', '市辖区', 3, 2607, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3083, '530802', '530800', '思茅区', 3, 2608, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3085, '530821', '530800', '宁洱哈尼族彝族自治县', 3, 2609, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3087, '530822', '530800', '墨江哈尼族自治县', 3, 2610, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3089, '530823', '530800', '景东彝族自治县', 3, 2611, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3091, '530824', '530800', '景谷傣族彝族自治县', 3, 2612, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3093, '530826', '530800', '江城哈尼族彝族自治县', 3, 2614, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3095, '530828', '530800', '澜沧拉祜族自治县', 3, 2616, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3097, '530829', '530800', '西盟佤族自治县', 3, 2617, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3099, '530901', '530900', '市辖区', 3, 2618, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3101, '530902', '530900', '临翔区', 3, 2619, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3103, '530921', '530900', '凤庆县', 3, 2620, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3105, '530922', '530900', '云县', 3, 2621, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3107, '530923', '530900', '永德县', 3, 2622, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3109, '530924', '530900', '镇康县', 3, 2623, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3111, '530926', '530900', '耿马傣族佤族自治县', 3, 2625, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3113, '530927', '530900', '沧源佤族自治县', 3, 2626, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3115, '532301', '532300', '楚雄市', 3, 2627, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3117, '532322', '532300', '双柏县', 3, 2628, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3119, '532323', '532300', '牟定县', 3, 2629, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3121, '532324', '532300', '南华县', 3, 2630, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3123, '532325', '532300', '姚安县', 3, 2631, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3125, '532326', '532300', '大姚县', 3, 2632, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3127, '532327', '532300', '永仁县', 3, 2633, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3129, '532328', '532300', '元谋县', 3, 2634, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3131, '532329', '532300', '武定县', 3, 2635, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3133, '532331', '532300', '禄丰县', 3, 2636, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3135, '532501', '532500', '个旧市', 3, 2637, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3137, '532502', '532500', '开远市', 3, 2638, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3139, '532503', '532500', '蒙自市', 3, 2639, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3141, '532523', '532500', '屏边苗族自治县', 3, 2641, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3143, '532524', '532500', '建水县', 3, 2642, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3145, '532525', '532500', '石屏县', 3, 2643, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3147, '532530', '532500', '金平苗族瑶族傣族自治县', 3, 2647, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3149, '532527', '532500', '泸西县', 3, 2644, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3151, '532528', '532500', '元阳县', 3, 2645, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3153, '532529', '532500', '红河县', 3, 2646, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3155, '532531', '532500', '绿春县', 3, 2648, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3157, '532532', '532500', '河口瑶族自治县', 3, 2649, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3159, '532601', '532600', '文山市', 3, 2650, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3161, '532622', '532600', '砚山县', 3, 2651, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3163, '532623', '532600', '西畴县', 3, 2652, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3165, '532624', '532600', '麻栗坡县', 3, 2653, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3167, '532625', '532600', '马关县', 3, 2654, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3169, '532626', '532600', '丘北县', 3, 2655, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3171, '532627', '532600', '广南县', 3, 2656, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3173, '532628', '532600', '富宁县', 3, 2657, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3175, '532801', '532800', '景洪市', 3, 2658, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3177, '532822', '532800', '勐海县', 3, 2659, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3179, '532823', '532800', '勐腊县', 3, 2660, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3181, '532901', '532900', '大理市', 3, 2661, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3183, '532922', '532900', '漾濞彝族自治县', 3, 2662, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3185, '532923', '532900', '祥云县', 3, 2663, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3187, '532924', '532900', '宾川县', 3, 2664, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3189, '532925', '532900', '弥渡县', 3, 2665, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3191, '532926', '532900', '南涧彝族自治县', 3, 2666, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3193, '532927', '532900', '巍山彝族回族自治县', 3, 2667, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3195, '532928', '532900', '永平县', 3, 2668, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3197, '532929', '532900', '云龙县', 3, 2669, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3199, '532930', '532900', '洱源县', 3, 2670, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3201, '532931', '532900', '剑川县', 3, 2671, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3203, '532932', '532900', '鹤庆县', 3, 2672, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3205, '533102', '533100', '瑞丽市', 3, 2673, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3207, '533103', '533100', '芒市', 3, 2674, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3209, '533122', '533100', '梁河县', 3, 2675, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3211, '533123', '533100', '盈江县', 3, 2676, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3213, '533124', '533100', '陇川县', 3, 2677, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3215, '533323', '533300', '福贡县', 3, 2679, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3217, '533324', '533300', '贡山独龙族怒族自治县', 3, 2680, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3219, '533325', '533300', '兰坪白族普米族自治县', 3, 2681, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3221, '533401', '533400', '香格里拉市', 3, 2682, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3223, '533422', '533400', '德钦县', 3, 2683, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3225, '533423', '533400', '维西傈僳族自治县', 3, 2684, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3227, '520622', '520600', '玉屏侗族自治县', 3, 2498, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3229, '520623', '520600', '石阡县', 3, 2499, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3231, '520624', '520600', '思南县', 3, 2450, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3233, '520625', '520600', '印江土家族苗族自治县', 3, 2451, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3235, '520626', '520600', '德江县', 3, 2452, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3237, '520627', '520600', '沿河土家族自治县', 3, 2453, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3239, '520628', '520600', '松桃苗族自治县', 3, 2454, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3241, '520603', '520600', '万山区', 3, 2496, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3243, '520501', '520500', '市辖区', 3, 2512, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3245, '520502', '520500', '七星关区', 3, 2513, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3247, '520521', '520500', '大方县', 3, 2514, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3249, '520522', '520500', '黔西县', 3, 2515, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3251, '520523', '520500', '金沙县', 3, 2516, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3253, '520524', '520500', '织金县', 3, 2517, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3255, '520527', '520500', '赫章县', 3, 2520, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3257, '522601', '522600', '凯里市', 3, 2520, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3259, '522622', '522600', '黄平县', 3, 2521, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3261, '522623', '522600', '施秉县', 3, 2522, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3263, '522624', '522600', '三穗县', 3, 2523, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3265, '522625', '522600', '镇远县', 3, 2524, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3267, '522626', '522600', '岑巩县', 3, 2525, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3269, '522627', '522600', '天柱县', 3, 2526, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3271, '522628', '522600', '锦屏县', 3, 2527, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3273, '522629', '522600', '剑河县', 3, 2528, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3275, '522630', '522600', '台江县', 3, 2529, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3277, '522631', '522600', '黎平县', 3, 2530, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3279, '522632', '522600', '榕江县', 3, 2531, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3281, '522633', '522600', '从江县', 3, 2532, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3283, '522634', '522600', '雷山县', 3, 2533, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3285, '522635', '522600', '麻江县', 3, 2534, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3287, '522636', '522600', '丹寨县', 3, 2535, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3289, '522701', '522700', '都匀市', 3, 2536, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3291, '522702', '522700', '福泉市', 3, 2537, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3293, '522722', '522700', '荔波县', 3, 2538, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3295, '522723', '522700', '贵定县', 3, 2539, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3297, '522725', '522700', '瓮安县', 3, 2540, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3299, '522726', '522700', '独山县', 3, 2541, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3301, '522727', '522700', '平塘县', 3, 2542, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3303, '522728', '522700', '罗甸县', 3, 2543, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3305, '522729', '522700', '长顺县', 3, 2544, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3307, '522730', '522700', '龙里县', 3, 2545, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3309, '522731', '522700', '惠水县', 3, 2546, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3311, '522732', '522700', '三都水族自治县', 3, 2547, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3313, '530101', '530100', '市辖区', 3, 2548, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3315, '530102', '530100', '五华区', 3, 2549, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3317, '530103', '530100', '盘龙区', 3, 2550, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3319, '530111', '530100', '官渡区', 3, 2551, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3321, '530112', '530100', '西山区', 3, 2552, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3323, '530113', '530100', '东川区', 3, 2553, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3325, '530114', '530100', '呈贡区', 3, 2554, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3327, '530122', '530100', '晋宁县', 3, 2555, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3329, '530124', '530100', '富民县', 3, 2556, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3331, '530125', '530100', '宜良县', 3, 2557, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3333, '530126', '530100', '石林彝族自治县', 3, 2558, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3335, '530127', '530100', '嵩明县', 3, 2559, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3337, '530128', '530100', '禄劝彝族苗族自治县', 3, 2560, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3339, '530129', '530100', '寻甸回族彝族自治县', 3, 2561, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3341, '530181', '530100', '安宁市', 3, 2562, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3343, '530301', '530300', '市辖区', 3, 2563, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3345, '530302', '530300', '麒麟区', 3, 2564, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3347, '530321', '530300', '马龙县', 3, 2565, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3349, '530322', '530300', '陆良县', 3, 2566, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3351, '530323', '530300', '师宗县', 3, 2567, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3353, '530324', '530300', '罗平县', 3, 2568, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3355, '530325', '530300', '富源县', 3, 2569, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3357, '530326', '530300', '会泽县', 3, 2570, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3359, '530381', '530300', '宣威市', 3, 2572, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3361, '530401', '530400', '市辖区', 3, 2573, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3363, '530402', '530400', '红塔区', 3, 2574, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3365, '530422', '530400', '澄江县', 3, 2576, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3367, '530423', '530400', '通海县', 3, 2577, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3369, '530424', '530400', '华宁县', 3, 2578, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3371, '530425', '530400', '易门县', 3, 2579, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3373, '530426', '530400', '峨山彝族自治县', 3, 2580, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3375, '530427', '530400', '新平彝族傣族自治县', 3, 2581, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3377, '530501', '530500', '市辖区', 3, 2583, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3379, '530502', '530500', '隆阳区', 3, 2584, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3381, '530521', '530500', '施甸县', 3, 2585, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3383, '530581', '530500', '腾冲市', 3, 2589, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3385, '530523', '530500', '龙陵县', 3, 2587, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3387, '530524', '530500', '昌宁县', 3, 2588, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3389, '530601', '530600', '市辖区', 3, 2589, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3391, '530602', '530600', '昭阳区', 3, 2590, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3393, '530621', '530600', '鲁甸县', 3, 2591, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3395, '530622', '530600', '巧家县', 3, 2592, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3397, '530623', '530600', '盐津县', 3, 2593, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3399, '610926', '610900', '平利县', 3, 2864, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3401, '610927', '610900', '镇坪县', 3, 2865, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3403, '610928', '610900', '旬阳县', 3, 2866, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3405, '610929', '610900', '白河县', 3, 2867, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3407, '611001', '611000', '市辖区', 3, 2868, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3409, '611002', '611000', '商州区', 3, 2869, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3411, '611021', '611000', '洛南县', 3, 2870, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3413, '611022', '611000', '丹凤县', 3, 2871, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3415, '611023', '611000', '商南县', 3, 2872, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3417, '611024', '611000', '山阳县', 3, 2873, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3419, '611025', '611000', '镇安县', 3, 2874, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3421, '611026', '611000', '柞水县', 3, 2875, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3423, '620101', '620100', '市辖区', 3, 2876, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3425, '620102', '620100', '城关区', 3, 2877, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3427, '620103', '620100', '七里河区', 3, 2878, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3429, '620104', '620100', '西固区', 3, 2879, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3431, '620105', '620100', '安宁区', 3, 2880, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3433, '620111', '620100', '红古区', 3, 2881, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3435, '620121', '620100', '永登县', 3, 2882, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3437, '620122', '620100', '皋兰县', 3, 2883, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3439, '620123', '620100', '榆中县', 3, 2884, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3441, '620201', '620200', '市辖区', 3, 2885, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3443, '620301', '620300', '市辖区', 3, 2886, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3445, '620302', '620300', '金川区', 3, 2887, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3447, '620321', '620300', '永昌县', 3, 2888, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3449, '620401', '620400', '市辖区', 3, 2889, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3451, '620402', '620400', '白银区', 3, 2890, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3453, '620403', '620400', '平川区', 3, 2891, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3455, '620421', '620400', '靖远县', 3, 2892, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3457, '620422', '620400', '会宁县', 3, 2893, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3459, '620423', '620400', '景泰县', 3, 2894, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3461, '620501', '620500', '市辖区', 3, 2895, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3463, '620502', '620500', '秦州区', 3, 2896, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3465, '620503', '620500', '麦积区', 3, 2897, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3467, '620521', '620500', '清水县', 3, 2898, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3469, '620522', '620500', '秦安县', 3, 2899, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3471, '620523', '620500', '甘谷县', 3, 2900, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3473, '620524', '620500', '武山县', 3, 2901, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3475, '620525', '620500', '张家川回族自治县', 3, 2902, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3477, '620601', '620600', '市辖区', 3, 2903, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3479, '620602', '620600', '凉州区', 3, 2904, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3481, '620621', '620600', '民勤县', 3, 2905, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3483, '620622', '620600', '古浪县', 3, 2906, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3485, '620623', '620600', '天祝藏族自治县', 3, 2907, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3487, '620701', '620700', '市辖区', 3, 2908, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3489, '620702', '620700', '甘州区', 3, 2909, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3491, '620721', '620700', '肃南裕固族自治县', 3, 2910, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3493, '620722', '620700', '民乐县', 3, 2911, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3495, '620723', '620700', '临泽县', 3, 2912, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3497, '620724', '620700', '高台县', 3, 2913, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3499, '620725', '620700', '山丹县', 3, 2914, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3501, '620801', '620800', '市辖区', 3, 2915, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3503, '620802', '620800', '崆峒区', 3, 2916, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3505, '620821', '620800', '泾川县', 3, 2917, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3507, '620822', '620800', '灵台县', 3, 2918, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3509, '620823', '620800', '崇信县', 3, 2919, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3511, '620824', '620800', '华亭县', 3, 2920, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3513, '620825', '620800', '庄浪县', 3, 2921, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3515, '620826', '620800', '静宁县', 3, 2922, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3517, '620901', '620900', '市辖区', 3, 2923, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3519, '620902', '620900', '肃州区', 3, 2924, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3521, '620921', '620900', '金塔县', 3, 2925, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3523, '620922', '620900', '瓜州县', 3, 2926, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3525, '620923', '620900', '肃北蒙古族自治县', 3, 2927, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3527, '620924', '620900', '阿克塞哈萨克族自治县', 3, 2928, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3529, '620981', '620900', '玉门市', 3, 2929, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3531, '620982', '620900', '敦煌市', 3, 2930, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3533, '621001', '621000', '市辖区', 3, 2931, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3535, '621002', '621000', '西峰区', 3, 2932, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3537, '621021', '621000', '庆城县', 3, 2933, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3539, '621022', '621000', '环县', 3, 2934, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3541, '621023', '621000', '华池县', 3, 2935, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3543, '621024', '621000', '合水县', 3, 2936, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3545, '621025', '621000', '正宁县', 3, 2937, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3547, '621026', '621000', '宁县', 3, 2938, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3549, '621027', '621000', '镇原县', 3, 2939, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3551, '621101', '621100', '市辖区', 3, 2940, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3553, '621102', '621100', '安定区', 3, 2941, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3555, '621121', '621100', '通渭县', 3, 2942, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3557, '621122', '621100', '陇西县', 3, 2943, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3559, '621123', '621100', '渭源县', 3, 2944, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3561, '621124', '621100', '临洮县', 3, 2945, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3563, '621125', '621100', '漳县', 3, 2946, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3565, '621126', '621100', '岷县', 3, 2947, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3567, '621201', '621200', '市辖区', 3, 2948, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3569, '621202', '621200', '武都区', 3, 2949, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3571, '621221', '621200', '成县', 3, 2950, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3573, '621222', '621200', '文县', 3, 2951, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3575, '621223', '621200', '宕昌县', 3, 2952, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3577, '410201', '410200', '市辖区', 3, 1518, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3579, '410202', '410200', '龙亭区', 3, 1519, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3581, '410203', '410200', '顺河回族区', 3, 1520, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3583, '410204', '410200', '鼓楼区', 3, 1521, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3585, '410205', '410200', '禹王台区', 3, 1522, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3587, '410211', '410200', '金明区', 3, 1523, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3589, '410221', '410200', '杞县', 3, 1525, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3591, '410222', '410200', '通许县', 3, 1526, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3593, '410223', '410200', '尉氏县', 3, 1527, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3595, '410212', '410200', '祥符区', 3, 1524, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3597, '410225', '410200', '兰考县', 3, 1528, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3599, '410301', '410300', '市辖区', 3, 1529, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3601, '410302', '410300', '老城区', 3, 1530, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3603, '410303', '410300', '西工区', 3, 1531, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3605, '410304', '410300', '瀍河回族区', 3, 1532, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3607, '410305', '410300', '涧西区', 3, 1533, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3609, '410306', '410300', '吉利区', 3, 1534, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3611, '410311', '410300', '洛龙区', 3, 1535, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3613, '410322', '410300', '孟津县', 3, 1536, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3615, '410323', '410300', '新安县', 3, 1537, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3617, '410324', '410300', '栾川县', 3, 1538, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3619, '410325', '410300', '嵩县', 3, 1539, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3621, '410326', '410300', '汝阳县', 3, 1540, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3623, '410327', '410300', '宜阳县', 3, 1541, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3625, '410328', '410300', '洛宁县', 3, 1542, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3627, '410329', '410300', '伊川县', 3, 1543, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3629, '410381', '410300', '偃师市', 3, 1544, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3631, '410401', '410400', '市辖区', 3, 1545, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3633, '410402', '410400', '新华区', 3, 1546, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3635, '410403', '410400', '卫东区', 3, 1547, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3637, '410404', '410400', '石龙区', 3, 1548, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3639, '410411', '410400', '湛河区', 3, 1549, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3641, '410421', '410400', '宝丰县', 3, 1550, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3643, '410422', '410400', '叶县', 3, 1551, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3645, '410423', '410400', '鲁山县', 3, 1552, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3647, '140221', '140200', '阳高县', 3, 236, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3649, '140222', '140200', '天镇县', 3, 237, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3651, '140223', '140200', '广灵县', 3, 238, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3653, '140224', '140200', '灵丘县', 3, 239, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3655, '140225', '140200', '浑源县', 3, 240, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3657, '140226', '140200', '左云县', 3, 241, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3659, '140227', '140200', '大同县', 3, 242, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3661, '140301', '140300', '市辖区', 3, 243, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3663, '140302', '140300', '城区', 3, 244, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3665, '140303', '140300', '矿区', 3, 245, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3667, '140311', '140300', '郊区', 3, 246, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3669, '140321', '140300', '平定县', 3, 247, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3671, '140322', '140300', '盂县', 3, 248, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3673, '140401', '140400', '市辖区', 3, 249, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3675, '140402', '140400', '城区', 3, 250, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3677, '140411', '140400', '郊区', 3, 251, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3679, '140421', '140400', '长治县', 3, 252, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3681, '140423', '140400', '襄垣县', 3, 253, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3683, '140424', '140400', '屯留县', 3, 254, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3685, '140425', '140400', '平顺县', 3, 255, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3687, '140426', '140400', '黎城县', 3, 256, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3689, '140427', '140400', '壶关县', 3, 257, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3691, '140428', '140400', '长子县', 3, 258, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3693, '140429', '140400', '武乡县', 3, 259, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3695, '140430', '140400', '沁县', 3, 260, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3697, '140431', '140400', '沁源县', 3, 261, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3699, '140481', '140400', '潞城市', 3, 262, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3701, '140501', '140500', '市辖区', 3, 263, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3703, '140502', '140500', '城区', 3, 264, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3705, '140521', '140500', '沁水县', 3, 265, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3707, '140522', '140500', '阳城县', 3, 266, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3709, '140524', '140500', '陵川县', 3, 267, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3711, '140525', '140500', '泽州县', 3, 268, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3713, '140581', '140500', '高平市', 3, 269, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3715, '140601', '140600', '市辖区', 3, 270, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3717, '140602', '140600', '朔城区', 3, 271, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3719, '140603', '140600', '平鲁区', 3, 272, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3721, '140621', '140600', '山阴县', 3, 273, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3723, '140622', '140600', '应县', 3, 274, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3725, '140623', '140600', '右玉县', 3, 275, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3727, '140624', '140600', '怀仁县', 3, 276, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3729, '140701', '140700', '市辖区', 3, 277, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3731, '140702', '140700', '榆次区', 3, 278, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3733, '140721', '140700', '榆社县', 3, 279, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3735, '140722', '140700', '左权县', 3, 280, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3737, '140723', '140700', '和顺县', 3, 281, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3739, '140724', '140700', '昔阳县', 3, 282, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3741, '140725', '140700', '寿阳县', 3, 283, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3743, '140726', '140700', '太谷县', 3, 284, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3745, '140727', '140700', '祁县', 3, 285, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3747, '140728', '140700', '平遥县', 3, 286, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3749, '140729', '140700', '灵石县', 3, 287, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3751, '140781', '140700', '介休市', 3, 288, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3753, '140801', '140800', '市辖区', 3, 289, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3755, '140802', '140800', '盐湖区', 3, 290, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3757, '140821', '140800', '临猗县', 3, 291, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3759, '140822', '140800', '万荣县', 3, 292, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3761, '140823', '140800', '闻喜县', 3, 293, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3763, '140824', '140800', '稷山县', 3, 294, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3765, '140825', '140800', '新绛县', 3, 295, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3767, '140826', '140800', '绛县', 3, 296, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3769, '140827', '140800', '垣曲县', 3, 297, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3771, '140828', '140800', '夏县', 3, 298, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3773, '140829', '140800', '平陆县', 3, 299, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3775, '140830', '140800', '芮城县', 3, 300, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3777, '140881', '140800', '永济市', 3, 301, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3779, '140882', '140800', '河津市', 3, 302, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3781, '140901', '140900', '市辖区', 3, 303, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3783, '140902', '140900', '忻府区', 3, 304, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3785, '140921', '140900', '定襄县', 3, 305, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3787, '140922', '140900', '五台县', 3, 306, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3789, '140923', '140900', '代县', 3, 307, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3791, '140924', '140900', '繁峙县', 3, 308, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3793, '140925', '140900', '宁武县', 3, 309, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3795, '140926', '140900', '静乐县', 3, 310, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3797, '140927', '140900', '神池县', 3, 311, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3799, '140928', '140900', '五寨县', 3, 312, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3801, '140929', '140900', '岢岚县', 3, 313, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3803, '140930', '140900', '河曲县', 3, 314, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3805, '140931', '140900', '保德县', 3, 315, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3807, '140932', '140900', '偏关县', 3, 316, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3809, '140981', '140900', '原平市', 3, 317, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3811, '141001', '141000', '市辖区', 3, 318, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3813, '141002', '141000', '尧都区', 3, 319, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3815, '141021', '141000', '曲沃县', 3, 320, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3817, '141022', '141000', '翼城县', 3, 321, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3819, '141023', '141000', '襄汾县', 3, 322, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3821, '141024', '141000', '洪洞县', 3, 323, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3823, '141025', '141000', '古县', 3, 324, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3825, '141026', '141000', '安泽县', 3, 325, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3827, '141027', '141000', '浮山县', 3, 326, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3829, '141028', '141000', '吉县', 3, 327, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3831, '141029', '141000', '乡宁县', 3, 328, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3833, '141030', '141000', '大宁县', 3, 329, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3835, '141031', '141000', '隰县', 3, 330, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3837, '141032', '141000', '永和县', 3, 331, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3839, '141033', '141000', '蒲县', 3, 332, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3841, '141034', '141000', '汾西县', 3, 333, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3843, '141081', '141000', '侯马市', 3, 334, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3845, '141082', '141000', '霍州市', 3, 335, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3847, '141101', '141100', '市辖区', 3, 336, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3849, '141102', '141100', '离石区', 3, 337, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3851, '141121', '141100', '文水县', 3, 338, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3853, '141122', '141100', '交城县', 3, 339, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3855, '141123', '141100', '兴县', 3, 340, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3857, '141124', '141100', '临县', 3, 341, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3859, '141125', '141100', '柳林县', 3, 342, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3861, '141126', '141100', '石楼县', 3, 343, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3863, '141127', '141100', '岚县', 3, 344, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3865, '141128', '141100', '方山县', 3, 345, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3867, '141129', '141100', '中阳县', 3, 346, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3869, '141130', '141100', '交口县', 3, 347, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3871, '141181', '141100', '孝义市', 3, 348, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3873, '141182', '141100', '汾阳市', 3, 349, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3875, '150101', '150100', '市辖区', 3, 350, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3877, '150102', '150100', '新城区', 3, 351, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3879, '150103', '150100', '回民区', 3, 352, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3881, '150104', '150100', '玉泉区', 3, 353, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3883, '150105', '150100', '赛罕区', 3, 354, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3885, '150121', '150100', '土默特左旗', 3, 355, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3887, '150122', '150100', '托克托县', 3, 356, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3889, '150123', '150100', '和林格尔县', 3, 357, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3891, '150124', '150100', '清水河县', 3, 358, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3893, '150125', '150100', '武川县', 3, 359, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3895, '150201', '150200', '市辖区', 3, 360, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3897, '150202', '150200', '东河区', 3, 361, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3899, '150203', '150200', '昆都仑区', 3, 362, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3901, '150204', '150200', '青山区', 3, 363, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3903, '150205', '150200', '石拐区', 3, 364, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3905, '150206', '150200', '白云鄂博矿区', 3, 365, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3907, '150207', '150200', '九原区', 3, 366, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3909, '150221', '150200', '土默特右旗', 3, 367, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3911, '150222', '150200', '固阳县', 3, 368, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3913, '150223', '150200', '达尔罕茂明安联合旗', 3, 369, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3915, '150301', '150300', '市辖区', 3, 370, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3917, '150302', '150300', '海勃湾区', 3, 371, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3919, '150303', '150300', '海南区', 3, 372, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3921, '150304', '150300', '乌达区', 3, 373, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3923, '150401', '150400', '市辖区', 3, 374, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3925, '150402', '150400', '红山区', 3, 375, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3927, '150403', '150400', '元宝山区', 3, 376, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3929, '150404', '150400', '松山区', 3, 377, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3931, '150421', '150400', '阿鲁科尔沁旗', 3, 378, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3933, '640521', '640500', '中宁县', 3, 3042, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3935, '640522', '640500', '海原县', 3, 3043, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3937, '650101', '650100', '市辖区', 3, 3044, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3939, '650102', '650100', '天山区', 3, 3045, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3941, '650103', '650100', '沙依巴克区', 3, 3046, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3943, '650104', '650100', '新市区', 3, 3047, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3945, '650105', '650100', '水磨沟区', 3, 3048, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3947, '650106', '650100', '头屯河区', 3, 3049, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3949, '650107', '650100', '达坂城区', 3, 3050, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3951, '650109', '650100', '米东区', 3, 3051, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3953, '650121', '650100', '乌鲁木齐县', 3, 3052, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3955, '650201', '650200', '市辖区', 3, 3053, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3957, '650202', '650200', '独山子区', 3, 3054, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3959, '650203', '650200', '克拉玛依区', 3, 3055, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3961, '650204', '650200', '白碱滩区', 3, 3056, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3963, '650205', '650200', '乌尔禾区', 3, 3057, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3965, '650402', '650400', '高昌区', 3, 3058, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3967, '650421', '650400', '鄯善县', 3, 3059, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3969, '650422', '650400', '托克逊县', 3, 3060, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3971, '652301', '652300', '昌吉市', 3, 3064, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3973, '652302', '652300', '阜康市', 3, 3065, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3975, '652323', '652300', '呼图壁县', 3, 3067, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3977, '652324', '652300', '玛纳斯县', 3, 3068, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3979, '652325', '652300', '奇台县', 3, 3069, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3981, '652327', '652300', '吉木萨尔县', 3, 3070, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3983, '652328', '652300', '木垒哈萨克自治县', 3, 3071, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3985, '652701', '652700', '博乐市', 3, 3072, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3987, '652722', '652700', '精河县', 3, 3074, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3989, '652723', '652700', '温泉县', 3, 3075, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3991, '652801', '652800', '库尔勒市', 3, 3075, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3993, '652822', '652800', '轮台县', 3, 3076, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3995, '652823', '652800', '尉犁县', 3, 3077, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3997, '652824', '652800', '若羌县', 3, 3078, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (3999, '652825', '652800', '且末县', 3, 3079, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4001, '652826', '652800', '焉耆回族自治县', 3, 3080, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4003, '652827', '652800', '和静县', 3, 3081, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4005, '652828', '652800', '和硕县', 3, 3082, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4007, '652829', '652800', '博湖县', 3, 3083, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4009, '652901', '652900', '阿克苏市', 3, 3084, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4011, '652922', '652900', '温宿县', 3, 3085, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4013, '652923', '652900', '库车县', 3, 3086, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4015, '652924', '652900', '沙雅县', 3, 3087, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4017, '652925', '652900', '新和县', 3, 3088, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4019, '652926', '652900', '拜城县', 3, 3089, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4021, '652927', '652900', '乌什县', 3, 3090, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4023, '652928', '652900', '阿瓦提县', 3, 3091, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4025, '652929', '652900', '柯坪县', 3, 3092, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4027, '653101', '653100', '喀什市', 3, 3097, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4029, '653121', '653100', '疏附县', 3, 3098, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4031, '653122', '653100', '疏勒县', 3, 3099, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4033, '653123', '653100', '英吉沙县', 3, 3100, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4035, '653124', '653100', '泽普县', 3, 3101, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4037, '653125', '653100', '莎车县', 3, 3102, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4039, '653126', '653100', '叶城县', 3, 3103, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4041, '653127', '653100', '麦盖提县', 3, 3104, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4043, '653128', '653100', '岳普湖县', 3, 3105, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4045, '653129', '653100', '伽师县', 3, 3106, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4047, '653130', '653100', '巴楚县', 3, 3107, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4049, '653201', '653200', '和田市', 3, 3109, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4051, '653221', '653200', '和田县', 3, 3110, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4053, '653222', '653200', '墨玉县', 3, 3111, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4055, '653223', '653200', '皮山县', 3, 3112, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4057, '653224', '653200', '洛浦县', 3, 3113, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4059, '653225', '653200', '策勒县', 3, 3114, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4061, '653226', '653200', '于田县', 3, 3115, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4063, '653227', '653200', '民丰县', 3, 3116, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4065, '654002', '654000', '伊宁市', 3, 3116, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4067, '654003', '654000', '奎屯市', 3, 3117, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4069, '654021', '654000', '伊宁县', 3, 3119, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4071, '654022', '654000', '察布查尔锡伯自治县', 3, 3120, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4073, '654023', '654000', '霍城县', 3, 3121, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4075, '654024', '654000', '巩留县', 3, 3122, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4077, '654025', '654000', '新源县', 3, 3123, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4079, '654026', '654000', '昭苏县', 3, 3124, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4081, '654027', '654000', '特克斯县', 3, 3125, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4083, '654028', '654000', '尼勒克县', 3, 3126, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4085, '654201', '654200', '塔城市', 3, 3127, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4087, '654202', '654200', '乌苏市', 3, 3128, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4089, '654221', '654200', '额敏县', 3, 3129, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4091, '654223', '654200', '沙湾县', 3, 3130, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4093, '654224', '654200', '托里县', 3, 3131, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4095, '654225', '654200', '裕民县', 3, 3132, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4097, '654226', '654200', '和布克赛尔蒙古自治县', 3, 3133, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4099, '654301', '654300', '阿勒泰市', 3, 3134, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4101, '410185', '410100', '登封市', 3, 1517, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4103, '210113', '210100', '沈北新区', 3, 467, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4105, '210114', '210100', '于洪区', 3, 468, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4107, '210123', '210100', '康平县', 3, 470, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4109, '210124', '210100', '法库县', 3, 471, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4111, '210181', '210100', '新民市', 3, 472, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4113, '210201', '210200', '市辖区', 3, 473, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4115, '210202', '210200', '中山区', 3, 474, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4117, '210203', '210200', '西岗区', 3, 475, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4119, '210204', '210200', '沙河口区', 3, 476, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4121, '210211', '210200', '甘井子区', 3, 477, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4123, '210212', '210200', '旅顺口区', 3, 478, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4125, '210213', '210200', '金州区', 3, 479, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4127, '210224', '210200', '长海县', 3, 480, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4129, '210281', '210200', '瓦房店市', 3, 481, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4131, '210283', '210200', '庄河市', 3, 483, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4133, '210301', '210300', '市辖区', 3, 484, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4135, '210302', '210300', '铁东区', 3, 485, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4137, '210303', '210300', '铁西区', 3, 486, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4139, '210304', '210300', '立山区', 3, 487, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4141, '210311', '210300', '千山区', 3, 488, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4143, '210321', '210300', '台安县', 3, 489, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4145, '210323', '210300', '岫岩满族自治县', 3, 490, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4147, '210381', '210300', '海城市', 3, 491, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4149, '210401', '210400', '市辖区', 3, 492, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4151, '210402', '210400', '新抚区', 3, 493, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4153, '210403', '210400', '东洲区', 3, 494, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4155, '210404', '210400', '望花区', 3, 495, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4157, '210411', '210400', '顺城区', 3, 496, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4159, '210421', '210400', '抚顺县', 3, 497, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4161, '210422', '210400', '新宾满族自治县', 3, 498, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4163, '210423', '210400', '清原满族自治县', 3, 499, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4165, '210501', '210500', '市辖区', 3, 500, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4167, '210502', '210500', '平山区', 3, 501, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4169, '210503', '210500', '溪湖区', 3, 502, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4171, '210504', '210500', '明山区', 3, 503, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4173, '210505', '210500', '南芬区', 3, 504, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4175, '210521', '210500', '本溪满族自治县', 3, 505, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4177, '210522', '210500', '桓仁满族自治县', 3, 506, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4179, '210601', '210600', '市辖区', 3, 507, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4181, '210602', '210600', '元宝区', 3, 508, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4183, '210603', '210600', '振兴区', 3, 509, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4185, '210604', '210600', '振安区', 3, 510, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4187, '210624', '210600', '宽甸满族自治县', 3, 511, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4189, '210681', '210600', '东港市', 3, 512, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4191, '210682', '210600', '凤城市', 3, 513, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4193, '210701', '210700', '市辖区', 3, 514, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4195, '210702', '210700', '古塔区', 3, 515, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4197, '210703', '210700', '凌河区', 3, 516, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4199, '210711', '210700', '太和区', 3, 517, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4201, '210726', '210700', '黑山县', 3, 518, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4203, '210727', '210700', '义县', 3, 519, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4205, '210781', '210700', '凌海市', 3, 520, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4207, '210782', '210700', '北镇市', 3, 521, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4209, '210801', '210800', '市辖区', 3, 522, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4211, '210802', '210800', '站前区', 3, 523, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4213, '210803', '210800', '西市区', 3, 524, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4215, '210804', '210800', '鲅鱼圈区', 3, 525, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4217, '210811', '210800', '老边区', 3, 526, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4219, '210881', '210800', '盖州市', 3, 527, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4221, '210882', '210800', '大石桥市', 3, 528, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4223, '210901', '210900', '市辖区', 3, 529, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4225, '210902', '210900', '海州区', 3, 530, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4227, '210903', '210900', '新邱区', 3, 531, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4229, '210904', '210900', '太平区', 3, 532, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4231, '210905', '210900', '清河门区', 3, 533, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4233, '210911', '210900', '细河区', 3, 534, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4235, '210921', '210900', '阜新蒙古族自治县', 3, 535, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4237, '210922', '210900', '彰武县', 3, 536, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4239, '211001', '211000', '市辖区', 3, 537, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4241, '211002', '211000', '白塔区', 3, 538, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4243, '211003', '211000', '文圣区', 3, 539, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4245, '211004', '211000', '宏伟区', 3, 540, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4247, '211005', '211000', '弓长岭区', 3, 541, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4249, '211011', '211000', '太子河区', 3, 542, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4251, '211021', '211000', '辽阳县', 3, 543, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4253, '211081', '211000', '灯塔市', 3, 544, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4255, '211101', '211100', '市辖区', 3, 545, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4257, '211102', '211100', '双台子区', 3, 546, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4259, '211103', '211100', '兴隆台区', 3, 547, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4261, '211122', '211100', '盘山县', 3, 549, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4263, '211201', '211200', '市辖区', 3, 550, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4265, '211202', '211200', '银州区', 3, 551, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4267, '211204', '211200', '清河区', 3, 552, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4269, '211221', '211200', '铁岭县', 3, 553, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4271, '654321', '654300', '布尔津县', 3, 3135, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4273, '654322', '654300', '富蕴县', 3, 3136, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4275, '654323', '654300', '福海县', 3, 3137, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4277, '654324', '654300', '哈巴河县', 3, 3138, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4279, '654325', '654300', '青河县', 3, 3139, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4281, '654326', '654300', '吉木乃县', 3, 3140, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4283, '659001', '659000', '石河子市', 3, 3141, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4285, '659002', '659000', '阿拉尔市', 3, 3142, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4287, '659003', '659000', '图木舒克市', 3, 3143, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4289, '659004', '659000', '五家渠市', 3, 3144, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4291, '370982', '370900', '新泰市', 3, 1438, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4293, '370983', '370900', '肥城市', 3, 1439, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4295, '371001', '371000', '市辖区', 3, 1440, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4297, '371002', '371000', '环翠区', 3, 1441, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4299, '371003', '371000', '文登区', 3, 1442, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4301, '371082', '371000', '荣成市', 3, 1443, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4303, '371083', '371000', '乳山市', 3, 1444, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4305, '371101', '371100', '市辖区', 3, 1445, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4307, '371102', '371100', '东港区', 3, 1446, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4309, '371103', '371100', '岚山区', 3, 1447, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4311, '371121', '371100', '五莲县', 3, 1448, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4313, '371122', '371100', '莒县', 3, 1449, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4315, '371201', '371200', '市辖区', 3, 1450, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4317, '371202', '371200', '莱城区', 3, 1451, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4319, '371203', '371200', '钢城区', 3, 1452, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4321, '371301', '371300', '市辖区', 3, 1453, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4323, '371302', '371300', '兰山区', 3, 1454, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4325, '371311', '371300', '罗庄区', 3, 1455, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4327, '371312', '371300', '河东区', 3, 1456, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4329, '371321', '371300', '沂南县', 3, 1457, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4331, '371322', '371300', '郯城县', 3, 1458, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4333, '371323', '371300', '沂水县', 3, 1459, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4335, '371324', '371300', '兰陵县', 3, 1460, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4337, '371325', '371300', '费县', 3, 1461, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4339, '371326', '371300', '平邑县', 3, 1462, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4341, '371327', '371300', '莒南县', 3, 1463, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4343, '371328', '371300', '蒙阴县', 3, 1464, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4345, '371329', '371300', '临沭县', 3, 1465, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4347, '371401', '371400', '市辖区', 3, 1466, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4349, '371402', '371400', '德城区', 3, 1467, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4351, '371403', '371400', '陵城区', 3, 1468, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4353, '371422', '371400', '宁津县', 3, 1469, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4355, '371423', '371400', '庆云县', 3, 1470, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4357, '371424', '371400', '临邑县', 3, 1471, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4359, '371425', '371400', '齐河县', 3, 1472, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4361, '371426', '371400', '平原县', 3, 1473, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4363, '371427', '371400', '夏津县', 3, 1474, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4365, '371428', '371400', '武城县', 3, 1475, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4367, '371481', '371400', '乐陵市', 3, 1476, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4369, '371482', '371400', '禹城市', 3, 1477, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4371, '371501', '371500', '市辖区', 3, 1478, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4373, '371502', '371500', '东昌府区', 3, 1479, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4375, '371521', '371500', '阳谷县', 3, 1480, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4377, '371522', '371500', '莘县', 3, 1481, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4379, '371523', '371500', '茌平县', 3, 1482, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4381, '371524', '371500', '东阿县', 3, 1483, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4383, '371525', '371500', '冠县', 3, 1484, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4385, '371526', '371500', '高唐县', 3, 1485, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4387, '371581', '371500', '临清市', 3, 1486, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4389, '371601', '371600', '市辖区', 3, 1487, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4391, '371602', '371600', '滨城区', 3, 1488, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4393, '371621', '371600', '惠民县', 3, 1490, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4395, '371622', '371600', '阳信县', 3, 1491, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4397, '371623', '371600', '无棣县', 3, 1492, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4399, '371603', '371600', '沾化区', 3, 1489, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4401, '371625', '371600', '博兴县', 3, 1493, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4403, '371626', '371600', '邹平县', 3, 1494, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4405, '371701', '371700', '市辖区', 3, 1495, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4407, '371702', '371700', '牡丹区', 3, 1496, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4409, '371721', '371700', '曹县', 3, 1497, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4411, '371722', '371700', '单县', 3, 1498, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4413, '371723', '371700', '成武县', 3, 1499, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4415, '371724', '371700', '巨野县', 3, 1500, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4417, '371725', '371700', '郓城县', 3, 1501, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4419, '371726', '371700', '鄄城县', 3, 1502, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4421, '371728', '371700', '东明县', 3, 1504, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4423, '410101', '410100', '市辖区', 3, 1505, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4425, '410102', '410100', '中原区', 3, 1506, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4427, '410103', '410100', '二七区', 3, 1507, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4429, '410104', '410100', '管城回族区', 3, 1508, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4431, '410105', '410100', '金水区', 3, 1509, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4433, '410106', '410100', '上街区', 3, 1510, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4435, '410108', '410100', '惠济区', 3, 1511, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4437, '410122', '410100', '中牟县', 3, 1512, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4439, '410181', '410100', '巩义市', 3, 1513, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4441, '410182', '410100', '荥阳市', 3, 1514, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4443, '410183', '410100', '新密市', 3, 1515, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4445, '410184', '410100', '新郑市', 3, 1516, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4447, '150422', '150400', '巴林左旗', 3, 379, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4449, '150423', '150400', '巴林右旗', 3, 380, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4451, '150424', '150400', '林西县', 3, 381, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4453, '150425', '150400', '克什克腾旗', 3, 382, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4455, '150426', '150400', '翁牛特旗', 3, 383, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4457, '150428', '150400', '喀喇沁旗', 3, 384, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4459, '150429', '150400', '宁城县', 3, 385, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4461, '150430', '150400', '敖汉旗', 3, 386, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4463, '150501', '150500', '市辖区', 3, 387, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4465, '150502', '150500', '科尔沁区', 3, 388, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4467, '150521', '150500', '科尔沁左翼中旗', 3, 389, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4469, '150522', '150500', '科尔沁左翼后旗', 3, 390, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4471, '150523', '150500', '开鲁县', 3, 391, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4473, '150524', '150500', '库伦旗', 3, 392, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4475, '150525', '150500', '奈曼旗', 3, 393, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4477, '150526', '150500', '扎鲁特旗', 3, 394, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4479, '150581', '150500', '霍林郭勒市', 3, 395, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4481, '150602', '150600', '东胜区', 3, 396, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4483, '150621', '150600', '达拉特旗', 3, 397, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4485, '150622', '150600', '准格尔旗', 3, 398, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4487, '150623', '150600', '鄂托克前旗', 3, 399, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4489, '150624', '150600', '鄂托克旗', 3, 400, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4491, '150625', '150600', '杭锦旗', 3, 401, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4493, '150626', '150600', '乌审旗', 3, 402, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4495, '150627', '150600', '伊金霍洛旗', 3, 403, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4497, '150701', '150700', '市辖区', 3, 404, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4499, '150702', '150700', '海拉尔区', 3, 405, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4501, '150721', '150700', '阿荣旗', 3, 407, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4503, '150723', '150700', '鄂伦春自治旗', 3, 409, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4505, '150724', '150700', '鄂温克族自治旗', 3, 410, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4507, '150725', '150700', '陈巴尔虎旗', 3, 411, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4509, '150726', '150700', '新巴尔虎左旗', 3, 412, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4511, '150727', '150700', '新巴尔虎右旗', 3, 413, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4513, '150781', '150700', '满洲里市', 3, 414, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4515, '150782', '150700', '牙克石市', 3, 415, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4517, '150783', '150700', '扎兰屯市', 3, 416, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4519, '150784', '150700', '额尔古纳市', 3, 417, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4521, '150785', '150700', '根河市', 3, 418, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4523, '150801', '150800', '市辖区', 3, 418, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4525, '150802', '150800', '临河区', 3, 419, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4527, '150821', '150800', '五原县', 3, 420, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4529, '150822', '150800', '磴口县', 3, 421, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4531, '150823', '150800', '乌拉特前旗', 3, 422, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4533, '150824', '150800', '乌拉特中旗', 3, 423, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4535, '150825', '150800', '乌拉特后旗', 3, 424, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4537, '150826', '150800', '杭锦后旗', 3, 425, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4539, '150901', '150900', '市辖区', 3, 426, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4541, '150902', '150900', '集宁区', 3, 427, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4543, '150921', '150900', '卓资县', 3, 428, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4545, '150922', '150900', '化德县', 3, 429, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4547, '150923', '150900', '商都县', 3, 430, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4549, '150924', '150900', '兴和县', 3, 431, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4551, '150925', '150900', '凉城县', 3, 432, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4553, '150926', '150900', '察哈尔右翼前旗', 3, 433, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4555, '150927', '150900', '察哈尔右翼中旗', 3, 434, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4557, '150928', '150900', '察哈尔右翼后旗', 3, 435, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4559, '150929', '150900', '四子王旗', 3, 436, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4561, '150981', '150900', '丰镇市', 3, 437, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4563, '152201', '152200', '乌兰浩特市', 3, 438, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4565, '152202', '152200', '阿尔山市', 3, 439, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4567, '152221', '152200', '科尔沁右翼前旗', 3, 440, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4569, '152222', '152200', '科尔沁右翼中旗', 3, 441, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4571, '152223', '152200', '扎赉特旗', 3, 442, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4573, '152224', '152200', '突泉县', 3, 443, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4575, '152501', '152500', '二连浩特市', 3, 444, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4577, '152502', '152500', '锡林浩特市', 3, 445, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4579, '152522', '152500', '阿巴嘎旗', 3, 446, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4581, '152523', '152500', '苏尼特左旗', 3, 447, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4583, '152524', '152500', '苏尼特右旗', 3, 448, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4585, '152525', '152500', '东乌珠穆沁旗', 3, 449, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4587, '152526', '152500', '西乌珠穆沁旗', 3, 450, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4589, '152527', '152500', '太仆寺旗', 3, 451, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4591, '152528', '152500', '镶黄旗', 3, 452, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4593, '152529', '152500', '正镶白旗', 3, 453, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4595, '152530', '152500', '正蓝旗', 3, 454, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4597, '152531', '152500', '多伦县', 3, 455, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4599, '152921', '152900', '阿拉善左旗', 3, 456, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4601, '152922', '152900', '阿拉善右旗', 3, 457, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4603, '152923', '152900', '额济纳旗', 3, 458, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4605, '210101', '210100', '市辖区', 3, 459, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4607, '210102', '210100', '和平区', 3, 460, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4609, '210103', '210100', '沈河区', 3, 461, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4611, '210104', '210100', '大东区', 3, 462, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4613, '210105', '210100', '皇姑区', 3, 463, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4615, '210106', '210100', '铁西区', 3, 464, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4617, '210111', '210100', '苏家屯区', 3, 465, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4619, '210112', '210100', '浑南区', 3, 466, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4621, '621224', '621200', '康县', 3, 2953, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4623, '621225', '621200', '西和县', 3, 2954, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4625, '621226', '621200', '礼县', 3, 2955, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4627, '621227', '621200', '徽县', 3, 2956, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4629, '621228', '621200', '两当县', 3, 2957, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4631, '622901', '622900', '临夏市', 3, 2958, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4633, '622921', '622900', '临夏县', 3, 2959, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4635, '622922', '622900', '康乐县', 3, 2960, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4637, '622923', '622900', '永靖县', 3, 2961, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4639, '622924', '622900', '广河县', 3, 2962, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4641, '622925', '622900', '和政县', 3, 2963, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4643, '622926', '622900', '东乡族自治县', 3, 2964, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4645, '623001', '623000', '合作市', 3, 2966, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4647, '623021', '623000', '临潭县', 3, 2967, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4649, '623022', '623000', '卓尼县', 3, 2968, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4651, '623023', '623000', '舟曲县', 3, 2969, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4653, '623024', '623000', '迭部县', 3, 2970, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4655, '623025', '623000', '玛曲县', 3, 2971, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4657, '623026', '623000', '碌曲县', 3, 2972, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4659, '623027', '623000', '夏河县', 3, 2973, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4661, '630101', '630100', '市辖区', 3, 2974, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4663, '630102', '630100', '城东区', 3, 2975, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4665, '630103', '630100', '城中区', 3, 2976, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4667, '630104', '630100', '城西区', 3, 2977, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4669, '630105', '630100', '城北区', 3, 2978, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4671, '630121', '630100', '大通回族土族自治县', 3, 2979, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4673, '630122', '630100', '湟中县', 3, 2980, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4675, '630123', '630100', '湟源县', 3, 2981, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4677, '630202', '630200', '乐都区', 3, 2982, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4679, '630222', '630200', '民和回族土族自治县', 3, 2984, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4681, '630203', '630200', '平安区', 3, 2983, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4683, '630223', '630200', '互助土族自治县', 3, 2985, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4685, '630224', '630200', '化隆回族自治县', 3, 2986, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4687, '630225', '630200', '循化撒拉族自治县', 3, 2987, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4689, '632221', '632200', '门源回族自治县', 3, 2988, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4691, '632222', '632200', '祁连县', 3, 2989, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4693, '632223', '632200', '海晏县', 3, 2990, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4695, '632224', '632200', '刚察县', 3, 2991, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4697, '632321', '632300', '同仁县', 3, 2992, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4699, '632322', '632300', '尖扎县', 3, 2993, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4701, '632323', '632300', '泽库县', 3, 2994, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4703, '632324', '632300', '河南蒙古族自治县', 3, 2995, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4705, '632521', '632500', '共和县', 3, 2996, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4707, '632522', '632500', '同德县', 3, 2997, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4709, '632523', '632500', '贵德县', 3, 2998, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4711, '632524', '632500', '兴海县', 3, 2999, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4713, '632525', '632500', '贵南县', 3, 3000, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4715, '632621', '632600', '玛沁县', 3, 3001, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4717, '632622', '632600', '班玛县', 3, 3002, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4719, '632623', '632600', '甘德县', 3, 3003, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4721, '632624', '632600', '达日县', 3, 3004, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4723, '632625', '632600', '久治县', 3, 3005, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4725, '632626', '632600', '玛多县', 3, 3006, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4727, '632701', '632700', '玉树市', 3, 3007, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4729, '632722', '632700', '杂多县', 3, 3008, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4731, '632723', '632700', '称多县', 3, 3009, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4733, '632724', '632700', '治多县', 3, 3010, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4735, '632725', '632700', '囊谦县', 3, 3011, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4737, '632726', '632700', '曲麻莱县', 3, 3012, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4739, '632801', '632800', '格尔木市', 3, 3013, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4741, '632802', '632800', '德令哈市', 3, 3014, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4743, '632821', '632800', '乌兰县', 3, 3015, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4745, '632822', '632800', '都兰县', 3, 3016, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4747, '632823', '632800', '天峻县', 3, 3017, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4749, '640101', '640100', '市辖区', 3, 3018, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4751, '640104', '640100', '兴庆区', 3, 3019, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4753, '640105', '640100', '西夏区', 3, 3020, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4755, '640106', '640100', '金凤区', 3, 3021, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4757, '640121', '640100', '永宁县', 3, 3022, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4759, '640122', '640100', '贺兰县', 3, 3023, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4761, '640181', '640100', '灵武市', 3, 3024, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4763, '640201', '640200', '市辖区', 3, 3025, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4765, '640202', '640200', '大武口区', 3, 3026, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4767, '640205', '640200', '惠农区', 3, 3027, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4769, '640221', '640200', '平罗县', 3, 3028, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4771, '640301', '640300', '市辖区', 3, 3029, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4773, '640302', '640300', '利通区', 3, 3030, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4775, '640323', '640300', '盐池县', 3, 3032, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4777, '640324', '640300', '同心县', 3, 3033, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4779, '640381', '640300', '青铜峡市', 3, 3034, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4781, '640401', '640400', '市辖区', 3, 3034, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4783, '640402', '640400', '原州区', 3, 3035, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4785, '640422', '640400', '西吉县', 3, 3036, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4787, '640423', '640400', '隆德县', 3, 3037, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4789, '640424', '640400', '泾源县', 3, 3038, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4791, '640425', '640400', '彭阳县', 3, 3039, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4793, '640501', '640500', '市辖区', 3, 3040, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4795, '640502', '640500', '沙坡头区', 3, 3041, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4797, '650400', '650000', '吐鲁番市', 2, 333, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4799, '652300', '650000', '昌吉回族自治州', 2, 335, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4801, '652700', '650000', '博尔塔拉蒙古自治州', 2, 336, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4803, '652800', '650000', '巴音郭楞蒙古自治州', 2, 337, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4805, '652900', '650000', '阿克苏地区', 2, 338, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4807, '653100', '650000', '喀什地区', 2, 340, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4809, '653200', '650000', '和田地区', 2, 341, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4811, '654000', '650000', '伊犁哈萨克自治州', 2, 342, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4813, '654200', '650000', '塔城地区', 2, 343, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4815, '654300', '650000', '阿勒泰地区', 2, 344, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4817, '659000', '650000', '自治区直辖县级行政区划', 2, 345, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4819, '350104', '350100', '仓山区', 3, 1147, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4821, '350105', '350100', '马尾区', 3, 1148, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4823, '350111', '350100', '晋安区', 3, 1149, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4825, '350121', '350100', '闽侯县', 3, 1150, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4827, '350122', '350100', '连江县', 3, 1151, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4829, '350123', '350100', '罗源县', 3, 1152, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4831, '350124', '350100', '闽清县', 3, 1153, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4833, '350125', '350100', '永泰县', 3, 1154, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4835, '350128', '350100', '平潭县', 3, 1155, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4837, '350181', '350100', '福清市', 3, 1156, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4839, '350182', '350100', '长乐市', 3, 1157, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4841, '350201', '350200', '市辖区', 3, 1158, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4843, '350203', '350200', '思明区', 3, 1159, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4845, '350205', '350200', '海沧区', 3, 1160, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4847, '350206', '350200', '湖里区', 3, 1161, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4849, '350211', '350200', '集美区', 3, 1162, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4851, '350212', '350200', '同安区', 3, 1163, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4853, '350213', '350200', '翔安区', 3, 1164, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4855, '350301', '350300', '市辖区', 3, 1165, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4857, '350302', '350300', '城厢区', 3, 1166, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4859, '350303', '350300', '涵江区', 3, 1167, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4861, '350304', '350300', '荔城区', 3, 1168, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4863, '350305', '350300', '秀屿区', 3, 1169, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4865, '350322', '350300', '仙游县', 3, 1170, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4867, '350401', '350400', '市辖区', 3, 1171, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4869, '350402', '350400', '梅列区', 3, 1172, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4871, '350403', '350400', '三元区', 3, 1173, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4873, '350421', '350400', '明溪县', 3, 1174, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4875, '350423', '350400', '清流县', 3, 1175, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4877, '350424', '350400', '宁化县', 3, 1176, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4879, '350425', '350400', '大田县', 3, 1177, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4881, '350426', '350400', '尤溪县', 3, 1178, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4883, '350427', '350400', '沙县', 3, 1179, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4885, '350428', '350400', '将乐县', 3, 1180, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4887, '350429', '350400', '泰宁县', 3, 1181, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4889, '350430', '350400', '建宁县', 3, 1182, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4891, '350481', '350400', '永安市', 3, 1183, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4893, '350501', '350500', '市辖区', 3, 1184, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4895, '350502', '350500', '鲤城区', 3, 1185, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4897, '350503', '350500', '丰泽区', 3, 1186, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4899, '350504', '350500', '洛江区', 3, 1187, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4901, '350505', '350500', '泉港区', 3, 1188, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4903, '350521', '350500', '惠安县', 3, 1189, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4905, '350524', '350500', '安溪县', 3, 1190, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4907, '350525', '350500', '永春县', 3, 1191, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4909, '350526', '350500', '德化县', 3, 1192, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4911, '350527', '350500', '金门县', 3, 1193, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4913, '350581', '350500', '石狮市', 3, 1194, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4915, '350582', '350500', '晋江市', 3, 1195, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4917, '350583', '350500', '南安市', 3, 1196, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4919, '350601', '350600', '市辖区', 3, 1197, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4921, '350602', '350600', '芗城区', 3, 1198, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4923, '350603', '350600', '龙文区', 3, 1199, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4925, '350622', '350600', '云霄县', 3, 1200, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4927, '350623', '350600', '漳浦县', 3, 1201, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4929, '350624', '350600', '诏安县', 3, 1202, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4931, '350625', '350600', '长泰县', 3, 1203, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4933, '350626', '350600', '东山县', 3, 1204, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4935, '350627', '350600', '南靖县', 3, 1205, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4937, '350628', '350600', '平和县', 3, 1206, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4939, '350629', '350600', '华安县', 3, 1207, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4941, '350681', '350600', '龙海市', 3, 1208, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4943, '350701', '350700', '市辖区', 3, 1209, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4945, '350702', '350700', '延平区', 3, 1210, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4947, '350721', '350700', '顺昌县', 3, 1212, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4949, '350722', '350700', '浦城县', 3, 1213, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4951, '350723', '350700', '光泽县', 3, 1214, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4953, '350724', '350700', '松溪县', 3, 1215, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4955, '350725', '350700', '政和县', 3, 1216, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4957, '350781', '350700', '邵武市', 3, 1217, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4959, '350782', '350700', '武夷山市', 3, 1218, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4961, '350783', '350700', '建瓯市', 3, 1219, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4963, '350703', '350700', '建阳区', 3, 1211, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4965, '350801', '350800', '市辖区', 3, 1220, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4967, '350802', '350800', '新罗区', 3, 1221, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4969, '350821', '350800', '长汀县', 3, 1223, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4971, '350803', '350800', '永定区', 3, 1222, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4973, '350823', '350800', '上杭县', 3, 1224, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4975, '350824', '350800', '武平县', 3, 1225, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4977, '350825', '350800', '连城县', 3, 1226, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4979, '350881', '350800', '漳平市', 3, 1227, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4981, '350901', '350900', '市辖区', 3, 1228, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4983, '350902', '350900', '蕉城区', 3, 1229, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4985, '350921', '350900', '霞浦县', 3, 1230, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4987, '350922', '350900', '古田县', 3, 1231, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4989, '350923', '350900', '屏南县', 3, 1232, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4991, '350924', '350900', '寿宁县', 3, 1233, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4993, '350925', '350900', '周宁县', 3, 1234, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4995, '350926', '350900', '柘荣县', 3, 1235, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4997, '350981', '350900', '福安市', 3, 1236, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (4999, '350982', '350900', '福鼎市', 3, 1237, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5001, '360101', '360100', '市辖区', 3, 1238, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5003, '360102', '360100', '东湖区', 3, 1239, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5005, '360103', '360100', '西湖区', 3, 1240, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5007, '360104', '360100', '青云谱区', 3, 1241, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5009, '360105', '360100', '湾里区', 3, 1242, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5011, '360111', '360100', '青山湖区', 3, 1243, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5013, '360121', '360100', '南昌县', 3, 1245, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5015, '360112', '360100', '新建区', 3, 1244, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5017, '360123', '360100', '安义县', 3, 1246, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5019, '360124', '360100', '进贤县', 3, 1247, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5021, '360201', '360200', '市辖区', 3, 1248, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5023, '360202', '360200', '昌江区', 3, 1249, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5025, '360203', '360200', '珠山区', 3, 1250, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5027, '360222', '360200', '浮梁县', 3, 1251, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5029, '360281', '360200', '乐平市', 3, 1252, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5031, '360301', '360300', '市辖区', 3, 1253, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5033, '360302', '360300', '安源区', 3, 1254, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5035, '360313', '360300', '湘东区', 3, 1255, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5037, '360321', '360300', '莲花县', 3, 1256, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5039, '360322', '360300', '上栗县', 3, 1257, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5041, '360323', '360300', '芦溪县', 3, 1258, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5043, '360401', '360400', '市辖区', 3, 1259, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5045, '360403', '360400', '浔阳区', 3, 1261, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5047, '360421', '360400', '九江县', 3, 1262, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5049, '360423', '360400', '武宁县', 3, 1263, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5051, '360424', '360400', '修水县', 3, 1264, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5053, '360425', '360400', '永修县', 3, 1265, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5055, '360426', '360400', '德安县', 3, 1266, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5057, '360428', '360400', '都昌县', 3, 1268, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5059, '360429', '360400', '湖口县', 3, 1269, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5061, '360430', '360400', '彭泽县', 3, 1270, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5063, '360481', '360400', '瑞昌市', 3, 1271, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5065, '360501', '360500', '市辖区', 3, 1272, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5067, '360502', '360500', '渝水区', 3, 1273, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5069, '360521', '360500', '分宜县', 3, 1274, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5071, '360601', '360600', '市辖区', 3, 1275, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5073, '360602', '360600', '月湖区', 3, 1276, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5075, '360622', '360600', '余江县', 3, 1277, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5077, '360681', '360600', '贵溪市', 3, 1278, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5079, '360701', '360700', '市辖区', 3, 1279, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5081, '360702', '360700', '章贡区', 3, 1280, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5083, '360721', '360700', '赣县', 3, 1282, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5085, '360722', '360700', '信丰县', 3, 1283, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5087, '360723', '360700', '大余县', 3, 1284, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5089, '360724', '360700', '上犹县', 3, 1285, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5091, '360725', '360700', '崇义县', 3, 1286, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5093, '360726', '360700', '安远县', 3, 1287, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5095, '360727', '360700', '龙南县', 3, 1288, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5097, '360728', '360700', '定南县', 3, 1289, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5099, '360729', '360700', '全南县', 3, 1290, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5101, '360730', '360700', '宁都县', 3, 1291, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5103, '360731', '360700', '于都县', 3, 1292, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5105, '360732', '360700', '兴国县', 3, 1293, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5107, '360733', '360700', '会昌县', 3, 1294, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5109, '360734', '360700', '寻乌县', 3, 1295, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5111, '360735', '360700', '石城县', 3, 1296, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5113, '360781', '360700', '瑞金市', 3, 1297, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5115, '360703', '360700', '南康区', 3, 1281, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5117, '360801', '360800', '市辖区', 3, 1298, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5119, '360802', '360800', '吉州区', 3, 1299, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5121, '360803', '360800', '青原区', 3, 1300, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5123, '360821', '360800', '吉安县', 3, 1301, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5125, '360822', '360800', '吉水县', 3, 1302, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5127, '360823', '360800', '峡江县', 3, 1303, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5129, '360824', '360800', '新干县', 3, 1304, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5131, '360825', '360800', '永丰县', 3, 1305, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5133, '360826', '360800', '泰和县', 3, 1306, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5135, '360827', '360800', '遂川县', 3, 1307, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5137, '360828', '360800', '万安县', 3, 1308, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5139, '360829', '360800', '安福县', 3, 1309, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5141, '360830', '360800', '永新县', 3, 1310, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5143, '360881', '360800', '井冈山市', 3, 1311, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5145, '360901', '360900', '市辖区', 3, 1312, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5147, '211223', '211200', '西丰县', 3, 554, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5149, '211224', '211200', '昌图县', 3, 555, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5151, '211281', '211200', '调兵山市', 3, 556, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5153, '211282', '211200', '开原市', 3, 557, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5155, '211301', '211300', '市辖区', 3, 558, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5157, '211302', '211300', '双塔区', 3, 559, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5159, '211303', '211300', '龙城区', 3, 560, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5161, '211321', '211300', '朝阳县', 3, 561, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5163, '211322', '211300', '建平县', 3, 562, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5165, '211381', '211300', '北票市', 3, 564, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5167, '211382', '211300', '凌源市', 3, 565, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5169, '211401', '211400', '市辖区', 3, 566, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5171, '211402', '211400', '连山区', 3, 567, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5173, '211403', '211400', '龙港区', 3, 568, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5175, '211404', '211400', '南票区', 3, 569, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5177, '211421', '211400', '绥中县', 3, 570, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5179, '211422', '211400', '建昌县', 3, 571, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5181, '211481', '211400', '兴城市', 3, 572, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5183, '220101', '220100', '市辖区', 3, 573, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5185, '220102', '220100', '南关区', 3, 574, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5187, '220103', '220100', '宽城区', 3, 575, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5189, '220104', '220100', '朝阳区', 3, 576, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5191, '220105', '220100', '二道区', 3, 577, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5193, '220106', '220100', '绿园区', 3, 578, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5195, '220112', '220100', '双阳区', 3, 579, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5197, '220122', '220100', '农安县', 3, 581, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5199, '220182', '220100', '榆树市', 3, 583, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5201, '220183', '220100', '德惠市', 3, 584, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5203, '220201', '220200', '市辖区', 3, 584, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5205, '220202', '220200', '昌邑区', 3, 585, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5207, '220203', '220200', '龙潭区', 3, 586, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5209, '220204', '220200', '船营区', 3, 587, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5211, '220211', '220200', '丰满区', 3, 588, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5213, '220221', '220200', '永吉县', 3, 589, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5215, '220281', '220200', '蛟河市', 3, 590, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5217, '220282', '220200', '桦甸市', 3, 591, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5219, '220283', '220200', '舒兰市', 3, 592, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5221, '220284', '220200', '磐石市', 3, 593, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5223, '220301', '220300', '市辖区', 3, 594, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5225, '220302', '220300', '铁西区', 3, 595, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5227, '220303', '220300', '铁东区', 3, 596, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5229, '220322', '220300', '梨树县', 3, 597, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5231, '220323', '220300', '伊通满族自治县', 3, 598, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5233, '220381', '220300', '公主岭市', 3, 599, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5235, '220382', '220300', '双辽市', 3, 600, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5237, '220401', '220400', '市辖区', 3, 601, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5239, '220402', '220400', '龙山区', 3, 602, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5241, '220403', '220400', '西安区', 3, 603, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5243, '220421', '220400', '东丰县', 3, 604, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5245, '220422', '220400', '东辽县', 3, 605, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5247, '220501', '220500', '市辖区', 3, 606, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5249, '220502', '220500', '东昌区', 3, 607, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5251, '220503', '220500', '二道江区', 3, 608, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5253, '220521', '220500', '通化县', 3, 609, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5255, '220523', '220500', '辉南县', 3, 610, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5257, '220524', '220500', '柳河县', 3, 611, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5259, '220581', '220500', '梅河口市', 3, 612, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5261, '220582', '220500', '集安市', 3, 613, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5263, '220601', '220600', '市辖区', 3, 614, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5265, '220602', '220600', '浑江区', 3, 615, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5267, '220621', '220600', '抚松县', 3, 617, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5269, '220622', '220600', '靖宇县', 3, 618, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5271, '220623', '220600', '长白朝鲜族自治县', 3, 619, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5273, '220605', '220600', '江源区', 3, 616, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5275, '220681', '220600', '临江市', 3, 620, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5277, '220701', '220700', '市辖区', 3, 621, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5279, '220702', '220700', '宁江区', 3, 622, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5281, '220722', '220700', '长岭县', 3, 624, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5283, '220723', '220700', '乾安县', 3, 625, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5285, '220781', '220700', '扶余市', 3, 626, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5287, '220801', '220800', '市辖区', 3, 627, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5289, '220802', '220800', '洮北区', 3, 628, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5291, '220821', '220800', '镇赉县', 3, 629, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5293, '220822', '220800', '通榆县', 3, 630, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5295, '220881', '220800', '洮南市', 3, 631, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5297, '220882', '220800', '大安市', 3, 632, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5299, '222401', '222400', '延吉市', 3, 633, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5301, '222402', '222400', '图们市', 3, 634, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5303, '222403', '222400', '敦化市', 3, 635, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5305, '222404', '222400', '珲春市', 3, 636, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5307, '222405', '222400', '龙井市', 3, 637, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5309, '222406', '222400', '和龙市', 3, 638, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5311, '222424', '222400', '汪清县', 3, 639, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5313, '222426', '222400', '安图县', 3, 640, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5315, '230101', '230100', '市辖区', 3, 641, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5317, '230102', '230100', '道里区', 3, 642, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5319, '230103', '230100', '南岗区', 3, 643, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5321, '230104', '230100', '道外区', 3, 644, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5323, '230110', '230100', '香坊区', 3, 645, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5325, '230108', '230100', '平房区', 3, 647, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5327, '230109', '230100', '松北区', 3, 648, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5329, '230111', '230100', '呼兰区', 3, 649, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5331, '230123', '230100', '依兰县', 3, 650, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5333, '230124', '230100', '方正县', 3, 651, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5335, '230125', '230100', '宾县', 3, 652, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5337, '230126', '230100', '巴彦县', 3, 653, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5339, '230127', '230100', '木兰县', 3, 654, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5341, '230128', '230100', '通河县', 3, 655, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5343, '230129', '230100', '延寿县', 3, 656, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5345, '230112', '230100', '阿城区', 3, 657, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5347, '230113', '230100', '双城区', 3, 658, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5349, '230183', '230100', '尚志市', 3, 659, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5351, '230184', '230100', '五常市', 3, 660, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5353, '230201', '230200', '市辖区', 3, 661, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5355, '230202', '230200', '龙沙区', 3, 662, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5357, '230203', '230200', '建华区', 3, 663, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5359, '230204', '230200', '铁锋区', 3, 664, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5361, '230205', '230200', '昂昂溪区', 3, 665, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5363, '230206', '230200', '富拉尔基区', 3, 666, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5365, '230207', '230200', '碾子山区', 3, 667, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5367, '230208', '230200', '梅里斯达斡尔族区', 3, 668, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5369, '230221', '230200', '龙江县', 3, 669, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5371, '110000', '0', '北京市', 1, 1, 0, '121', '2018-03-14 00:00:00', '2020-05-08 22:53:56');
INSERT INTO `sys_area` VALUES (5373, '120000', '0', '天津市', 1, 2, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5375, '130000', '0', '河北省', 1, 3, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5377, '140000', '0', '山西省', 1, 4, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5379, '150000', '0', '内蒙古自治区', 1, 5, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5381, '210000', '0', '辽宁省', 1, 6, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5383, '220000', '0', '吉林省', 1, 7, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5385, '230000', '0', '黑龙江省', 1, 8, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5387, '310000', '0', '上海市', 1, 9, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5389, '320000', '0', '江苏省', 1, 10, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5391, '330000', '0', '浙江省', 1, 11, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5393, '340000', '0', '安徽省', 1, 12, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5395, '350000', '0', '福建省', 1, 13, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5397, '360000', '0', '江西省', 1, 14, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5399, '370000', '0', '山东省', 1, 15, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5401, '410000', '0', '河南省', 1, 16, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5403, '420000', '0', '湖北省', 1, 17, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5405, '430000', '0', '湖南省', 1, 18, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5407, '440000', '0', '广东省', 1, 19, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5409, '450000', '0', '广西壮族自治区', 1, 20, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5411, '460000', '0', '海南省', 1, 21, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5413, '500000', '0', '重庆市', 1, 22, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5415, '510000', '0', '四川省', 1, 23, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5417, '520000', '0', '贵州省', 1, 24, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5419, '530000', '0', '云南省', 1, 25, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5421, '540000', '0', '西藏自治区', 1, 26, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5423, '610000', '0', '陕西省', 1, 27, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5425, '620000', '0', '甘肃省', 1, 28, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5427, '630000', '0', '青海省', 1, 29, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5429, '640000', '0', '宁夏回族自治区', 1, 30, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5431, '650000', '0', '新疆维吾尔自治区', 1, 31, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5433, '710000', '0', '台湾省', 1, 32, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5435, '810000', '0', '香港特别行政区', 1, 33, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5437, '820000', '0', '澳门特别行政区', 1, 34, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5439, '110100', '110000', '市辖区', 2, 1, 0, '', '2018-03-14 00:00:00', '2020-05-07 21:50:06');
INSERT INTO `sys_area` VALUES (5441, '120100', '120000', '市辖区', 2, 3, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5443, '130100', '130000', '石家庄市', 2, 5, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5445, '130200', '130000', '唐山市', 2, 6, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5447, '130300', '130000', '秦皇岛市', 2, 7, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5449, '130400', '130000', '邯郸市', 2, 8, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5451, '130500', '130000', '邢台市', 2, 9, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5453, '130600', '130000', '保定市', 2, 10, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5455, '130700', '130000', '张家口市', 2, 11, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5457, '130800', '130000', '承德市', 2, 12, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5459, '130900', '130000', '沧州市', 2, 13, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5461, '131000', '130000', '廊坊市', 2, 14, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5463, '131100', '130000', '衡水市', 2, 15, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5465, '140100', '140000', '太原市', 2, 16, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5467, '140200', '140000', '大同市', 2, 17, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5469, '140300', '140000', '阳泉市', 2, 18, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5471, '140400', '140000', '长治市', 2, 19, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5473, '140500', '140000', '晋城市', 2, 20, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5475, '140600', '140000', '朔州市', 2, 21, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5477, '140700', '140000', '晋中市', 2, 22, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5479, '140800', '140000', '运城市', 2, 23, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5481, '140900', '140000', '忻州市', 2, 24, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5483, '141000', '140000', '临汾市', 2, 25, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5485, '141100', '140000', '吕梁市', 2, 26, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5487, '150100', '150000', '呼和浩特市', 2, 27, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5489, '150200', '150000', '包头市', 2, 28, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5491, '150300', '150000', '乌海市', 2, 29, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5493, '150400', '150000', '赤峰市', 2, 30, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5495, '150500', '150000', '通辽市', 2, 31, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5497, '150600', '150000', '鄂尔多斯市', 2, 32, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5499, '150700', '150000', '呼伦贝尔市', 2, 33, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5501, '150800', '150000', '巴彦淖尔市', 2, 34, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5503, '150900', '150000', '乌兰察布市', 2, 35, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5505, '152200', '150000', '兴安盟', 2, 36, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5507, '152500', '150000', '锡林郭勒盟', 2, 37, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5509, '152900', '150000', '阿拉善盟', 2, 38, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5511, '210100', '210000', '沈阳市', 2, 39, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5513, '210200', '210000', '大连市', 2, 40, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5515, '210300', '210000', '鞍山市', 2, 41, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5517, '210400', '210000', '抚顺市', 2, 42, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5519, '210500', '210000', '本溪市', 2, 43, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5521, '210600', '210000', '丹东市', 2, 44, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5523, '210700', '210000', '锦州市', 2, 45, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5525, '210800', '210000', '营口市', 2, 46, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5527, '210900', '210000', '阜新市', 2, 47, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5529, '211000', '210000', '辽阳市', 2, 48, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5531, '211100', '210000', '盘锦市', 2, 49, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5533, '211200', '210000', '铁岭市', 2, 50, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5535, '211300', '210000', '朝阳市', 2, 51, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5537, '211400', '210000', '葫芦岛市', 2, 52, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5539, '220100', '220000', '长春市', 2, 53, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5541, '220200', '220000', '吉林市', 2, 54, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5543, '220300', '220000', '四平市', 2, 55, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5545, '220400', '220000', '辽源市', 2, 56, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5547, '220500', '220000', '通化市', 2, 57, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5549, '220600', '220000', '白山市', 2, 58, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5551, '220700', '220000', '松原市', 2, 59, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5553, '220800', '220000', '白城市', 2, 60, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5555, '222400', '220000', '延边朝鲜族自治州', 2, 61, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5557, '230100', '230000', '哈尔滨市', 2, 62, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5559, '230200', '230000', '齐齐哈尔市', 2, 63, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5561, '230300', '230000', '鸡西市', 2, 64, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5563, '230400', '230000', '鹤岗市', 2, 65, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5565, '230500', '230000', '双鸭山市', 2, 66, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5567, '230600', '230000', '大庆市', 2, 67, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5569, '230700', '230000', '伊春市', 2, 68, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5571, '230800', '230000', '佳木斯市', 2, 69, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5573, '230900', '230000', '七台河市', 2, 70, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5575, '231000', '230000', '牡丹江市', 2, 71, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5577, '231100', '230000', '黑河市', 2, 72, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5579, '231200', '230000', '绥化市', 2, 73, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5581, '232700', '230000', '大兴安岭地区', 2, 74, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5583, '310100', '310000', '市辖区', 2, 75, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5585, '320100', '320000', '南京市', 2, 77, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5587, '320200', '320000', '无锡市', 2, 78, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5589, '320300', '320000', '徐州市', 2, 79, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5591, '320400', '320000', '常州市', 2, 80, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5593, '320500', '320000', '苏州市', 2, 81, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5595, '320600', '320000', '南通市', 2, 82, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5597, '320700', '320000', '连云港市', 2, 83, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5599, '320800', '320000', '淮安市', 2, 84, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5601, '320900', '320000', '盐城市', 2, 85, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5603, '321000', '320000', '扬州市', 2, 86, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5605, '321100', '320000', '镇江市', 2, 87, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5607, '321200', '320000', '泰州市', 2, 88, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5609, '321300', '320000', '宿迁市', 2, 89, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5611, '330100', '330000', '杭州市', 2, 90, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5613, '330200', '330000', '宁波市', 2, 91, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5615, '330300', '330000', '温州市', 2, 92, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5617, '330400', '330000', '嘉兴市', 2, 93, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5619, '330500', '330000', '湖州市', 2, 94, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5621, '330600', '330000', '绍兴市', 2, 95, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5623, '330700', '330000', '金华市', 2, 96, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5625, '330800', '330000', '衢州市', 2, 97, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5627, '330900', '330000', '舟山市', 2, 98, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5629, '331000', '330000', '台州市', 2, 99, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5631, '331100', '330000', '丽水市', 2, 100, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5633, '340100', '340000', '合肥市', 2, 101, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5635, '340200', '340000', '芜湖市', 2, 102, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5637, '340300', '340000', '蚌埠市', 2, 103, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5639, '340400', '340000', '淮南市', 2, 104, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5641, '340500', '340000', '马鞍山市', 2, 105, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5643, '340600', '340000', '淮北市', 2, 106, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5645, '340700', '340000', '铜陵市', 2, 107, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5647, '340800', '340000', '安庆市', 2, 108, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5649, '341000', '340000', '黄山市', 2, 109, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5651, '341100', '340000', '滁州市', 2, 110, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5653, '341200', '340000', '阜阳市', 2, 111, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5655, '341300', '340000', '宿州市', 2, 112, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5657, '341500', '340000', '六安市', 2, 114, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5659, '341600', '340000', '亳州市', 2, 115, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5661, '341700', '340000', '池州市', 2, 116, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5663, '341800', '340000', '宣城市', 2, 117, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5665, '350100', '350000', '福州市', 2, 118, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5667, '350200', '350000', '厦门市', 2, 119, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5669, '350300', '350000', '莆田市', 2, 120, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5671, '350400', '350000', '三明市', 2, 121, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5673, '350500', '350000', '泉州市', 2, 122, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5675, '350600', '350000', '漳州市', 2, 123, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5677, '350700', '350000', '南平市', 2, 124, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5679, '350800', '350000', '龙岩市', 2, 125, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5681, '350900', '350000', '宁德市', 2, 126, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5683, '360100', '360000', '南昌市', 2, 127, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5685, '360200', '360000', '景德镇市', 2, 128, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5687, '360300', '360000', '萍乡市', 2, 129, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5689, '360400', '360000', '九江市', 2, 130, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5691, '360500', '360000', '新余市', 2, 131, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5693, '360600', '360000', '鹰潭市', 2, 132, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5695, '360700', '360000', '赣州市', 2, 133, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5697, '360800', '360000', '吉安市', 2, 134, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5699, '360900', '360000', '宜春市', 2, 135, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5701, '361000', '360000', '抚州市', 2, 136, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5703, '361100', '360000', '上饶市', 2, 137, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5705, '370100', '370000', '济南市', 2, 138, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5707, '370200', '370000', '青岛市', 2, 139, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5709, '370300', '370000', '淄博市', 2, 140, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5711, '500100', '500000', '市辖区', 2, 238, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5713, '500200', '500000', '县', 2, 239, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5715, '510100', '510000', '成都市', 2, 241, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5717, '510300', '510000', '自贡市', 2, 242, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5719, '510400', '510000', '攀枝花市', 2, 243, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5721, '510500', '510000', '泸州市', 2, 244, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5723, '510600', '510000', '德阳市', 2, 245, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5725, '510700', '510000', '绵阳市', 2, 246, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5727, '510800', '510000', '广元市', 2, 247, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5729, '510900', '510000', '遂宁市', 2, 248, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5731, '511000', '510000', '内江市', 2, 249, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5733, '511100', '510000', '乐山市', 2, 250, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5735, '511300', '510000', '南充市', 2, 251, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5737, '511400', '510000', '眉山市', 2, 252, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5739, '511500', '510000', '宜宾市', 2, 253, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5741, '511600', '510000', '广安市', 2, 254, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5743, '511700', '510000', '达州市', 2, 255, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5745, '511800', '510000', '雅安市', 2, 256, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5747, '511900', '510000', '巴中市', 2, 257, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5749, '512000', '510000', '资阳市', 2, 258, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5751, '513200', '510000', '阿坝藏族羌族自治州', 2, 259, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5753, '513300', '510000', '甘孜藏族自治州', 2, 260, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5755, '513400', '510000', '凉山彝族自治州', 2, 261, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5757, '520100', '520000', '贵阳市', 2, 262, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5759, '520200', '520000', '六盘水市', 2, 263, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5761, '520300', '520000', '遵义市', 2, 264, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5763, '520400', '520000', '安顺市', 2, 265, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5765, '520600', '520000', '铜仁市', 2, 267, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5767, '520500', '520000', '毕节市', 2, 266, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5769, '522600', '520000', '黔东南苗族侗族自治州', 2, 269, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5771, '522700', '520000', '黔南布依族苗族自治州', 2, 270, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5773, '530100', '530000', '昆明市', 2, 271, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5775, '530300', '530000', '曲靖市', 2, 272, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5777, '530400', '530000', '玉溪市', 2, 273, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5779, '530500', '530000', '保山市', 2, 274, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5781, '530600', '530000', '昭通市', 2, 275, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5783, '530700', '530000', '丽江市', 2, 276, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5785, '530800', '530000', '普洱市', 2, 277, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5787, '530900', '530000', '临沧市', 2, 278, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5789, '532300', '530000', '楚雄彝族自治州', 2, 279, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5791, '532500', '530000', '红河哈尼族彝族自治州', 2, 280, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5793, '532600', '530000', '文山壮族苗族自治州', 2, 281, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5795, '532800', '530000', '西双版纳傣族自治州', 2, 282, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5797, '532900', '530000', '大理白族自治州', 2, 283, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5799, '533100', '530000', '德宏傣族景颇族自治州', 2, 284, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5801, '533300', '530000', '怒江傈僳族自治州', 2, 285, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5803, '533400', '530000', '迪庆藏族自治州', 2, 286, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5805, '540100', '540000', '拉萨市', 2, 287, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5807, '540300', '540000', '昌都市', 2, 289, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5809, '540200', '540000', '日喀则市', 2, 288, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5811, '542400', '540000', '那曲地区', 2, 292, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5813, '542500', '540000', '阿里地区', 2, 293, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5815, '540400', '540000', '林芝市', 2, 290, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5817, '610100', '610000', '西安市', 2, 294, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5819, '610200', '610000', '铜川市', 2, 295, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5821, '610300', '610000', '宝鸡市', 2, 296, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5823, '610400', '610000', '咸阳市', 2, 297, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5825, '610500', '610000', '渭南市', 2, 298, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5827, '610600', '610000', '延安市', 2, 299, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5829, '610700', '610000', '汉中市', 2, 300, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5831, '610800', '610000', '榆林市', 2, 301, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5833, '610900', '610000', '安康市', 2, 302, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5835, '611000', '610000', '商洛市', 2, 303, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5837, '620100', '620000', '兰州市', 2, 304, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5839, '620200', '620000', '嘉峪关市', 2, 305, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5841, '620300', '620000', '金昌市', 2, 306, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5843, '620400', '620000', '白银市', 2, 307, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5845, '620500', '620000', '天水市', 2, 308, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5847, '620600', '620000', '武威市', 2, 309, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5849, '620700', '620000', '张掖市', 2, 310, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5851, '620800', '620000', '平凉市', 2, 311, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5853, '620900', '620000', '酒泉市', 2, 312, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5855, '621000', '620000', '庆阳市', 2, 313, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5857, '621100', '620000', '定西市', 2, 314, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5859, '621200', '620000', '陇南市', 2, 315, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5861, '622900', '620000', '临夏回族自治州', 2, 316, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5863, '623000', '620000', '甘南藏族自治州', 2, 317, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5865, '630100', '630000', '西宁市', 2, 318, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5867, '630200', '630000', '海东市', 2, 319, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5869, '632200', '630000', '海北藏族自治州', 2, 320, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5871, '632300', '630000', '黄南藏族自治州', 2, 321, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5873, '632500', '630000', '海南藏族自治州', 2, 322, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5875, '632600', '630000', '果洛藏族自治州', 2, 323, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5877, '632700', '630000', '玉树藏族自治州', 2, 324, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5879, '632800', '630000', '海西蒙古族藏族自治州', 2, 325, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5881, '640100', '640000', '银川市', 2, 326, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5883, '640200', '640000', '石嘴山市', 2, 327, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5885, '640300', '640000', '吴忠市', 2, 328, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5887, '640400', '640000', '固原市', 2, 329, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5889, '640500', '640000', '中卫市', 2, 330, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5891, '650100', '650000', '乌鲁木齐市', 2, 331, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5893, '650200', '650000', '克拉玛依市', 2, 332, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5895, '370400', '370000', '枣庄市', 2, 141, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5897, '370500', '370000', '东营市', 2, 142, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5899, '370600', '370000', '烟台市', 2, 143, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5901, '370700', '370000', '潍坊市', 2, 144, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5903, '370800', '370000', '济宁市', 2, 145, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5905, '370900', '370000', '泰安市', 2, 146, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5907, '371000', '370000', '威海市', 2, 147, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5909, '371100', '370000', '日照市', 2, 148, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5911, '371200', '370000', '莱芜市', 2, 149, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5913, '371300', '370000', '临沂市', 2, 150, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5915, '371400', '370000', '德州市', 2, 151, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5917, '371500', '370000', '聊城市', 2, 152, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5919, '371600', '370000', '滨州市', 2, 153, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5921, '371700', '370000', '菏泽市', 2, 154, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5923, '410100', '410000', '郑州市', 2, 155, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5925, '410200', '410000', '开封市', 2, 156, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5927, '410300', '410000', '洛阳市', 2, 157, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5929, '410400', '410000', '平顶山市', 2, 158, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5931, '410500', '410000', '安阳市', 2, 159, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5933, '410600', '410000', '鹤壁市', 2, 160, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5935, '410700', '410000', '新乡市', 2, 161, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5937, '410800', '410000', '焦作市', 2, 162, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5939, '410900', '410000', '濮阳市', 2, 163, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5941, '411000', '410000', '许昌市', 2, 164, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5943, '411100', '410000', '漯河市', 2, 165, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5945, '411200', '410000', '三门峡市', 2, 166, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5947, '411300', '410000', '南阳市', 2, 167, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5949, '411400', '410000', '商丘市', 2, 168, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5951, '411500', '410000', '信阳市', 2, 169, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5953, '411600', '410000', '周口市', 2, 170, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5955, '411700', '410000', '驻马店市', 2, 171, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5957, '420100', '420000', '武汉市', 2, 172, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5959, '420200', '420000', '黄石市', 2, 173, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5961, '420300', '420000', '十堰市', 2, 174, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5963, '420500', '420000', '宜昌市', 2, 175, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5965, '420600', '420000', '襄阳市', 2, 176, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5967, '420700', '420000', '鄂州市', 2, 177, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5969, '420800', '420000', '荆门市', 2, 178, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5971, '420900', '420000', '孝感市', 2, 179, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5973, '421000', '420000', '荆州市', 2, 180, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5975, '421100', '420000', '黄冈市', 2, 181, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5977, '421200', '420000', '咸宁市', 2, 182, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5979, '421300', '420000', '随州市', 2, 183, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5981, '422800', '420000', '恩施土家族苗族自治州', 2, 184, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5983, '429000', '420000', '省直辖行政单位', 2, 185, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5985, '430100', '430000', '长沙市', 2, 186, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5987, '430200', '430000', '株洲市', 2, 187, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5989, '430300', '430000', '湘潭市', 2, 188, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5991, '430400', '430000', '衡阳市', 2, 189, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5993, '430500', '430000', '邵阳市', 2, 190, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5995, '430600', '430000', '岳阳市', 2, 191, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5997, '430700', '430000', '常德市', 2, 192, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (5999, '430800', '430000', '张家界市', 2, 193, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6001, '430900', '430000', '益阳市', 2, 194, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6003, '431000', '430000', '郴州市', 2, 195, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6005, '431100', '430000', '永州市', 2, 196, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6007, '431200', '430000', '怀化市', 2, 197, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6009, '431300', '430000', '娄底市', 2, 198, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6011, '433100', '430000', '湘西土家族苗族自治州', 2, 199, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6013, '440100', '440000', '广州市', 2, 200, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6015, '440200', '440000', '韶关市', 2, 201, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6017, '440300', '440000', '深圳市', 2, 202, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6019, '440400', '440000', '珠海市', 2, 203, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6021, '440500', '440000', '汕头市', 2, 204, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6023, '440600', '440000', '佛山市', 2, 205, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6025, '440700', '440000', '江门市', 2, 206, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6027, '440800', '440000', '湛江市', 2, 207, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6029, '440900', '440000', '茂名市', 2, 208, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6031, '441200', '440000', '肇庆市', 2, 209, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6033, '441300', '440000', '惠州市', 2, 210, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6035, '441400', '440000', '梅州市', 2, 211, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6037, '441500', '440000', '汕尾市', 2, 212, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6039, '441600', '440000', '河源市', 2, 213, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6041, '441700', '440000', '阳江市', 2, 214, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6043, '441800', '440000', '清远市', 2, 215, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6045, '441900', '440000', '东莞市', 2, 216, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6047, '442000', '440000', '中山市', 2, 217, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6049, '445100', '440000', '潮州市', 2, 218, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6051, '445200', '440000', '揭阳市', 2, 219, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6053, '445300', '440000', '云浮市', 2, 220, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6055, '450100', '450000', '南宁市', 2, 221, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6057, '450200', '450000', '柳州市', 2, 222, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6059, '450300', '450000', '桂林市', 2, 223, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6061, '450400', '450000', '梧州市', 2, 224, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6063, '450500', '450000', '北海市', 2, 225, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6065, '450600', '450000', '防城港市', 2, 226, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6067, '450700', '450000', '钦州市', 2, 227, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6069, '450800', '450000', '贵港市', 2, 228, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6071, '450900', '450000', '玉林市', 2, 229, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6073, '451000', '450000', '百色市', 2, 230, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6075, '451100', '450000', '贺州市', 2, 231, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6077, '451200', '450000', '河池市', 2, 232, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6079, '451300', '450000', '来宾市', 2, 233, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6081, '451400', '450000', '崇左市', 2, 234, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6083, '460100', '460000', '海口市', 2, 235, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6085, '460200', '460000', '三亚市', 2, 236, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6087, '469000', '460000', '省直辖县级行政单位', 2, 238, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6089, '140211', '140200', '南郊区', 3, 234, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6091, '140212', '140200', '新荣区', 3, 235, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6093, '360902', '360900', '袁州区', 3, 1313, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6095, '360921', '360900', '奉新县', 3, 1314, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6097, '360922', '360900', '万载县', 3, 1315, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6099, '360923', '360900', '上高县', 3, 1316, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6101, '360924', '360900', '宜丰县', 3, 1317, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6103, '360925', '360900', '靖安县', 3, 1318, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6105, '360926', '360900', '铜鼓县', 3, 1319, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6107, '360981', '360900', '丰城市', 3, 1320, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6109, '360982', '360900', '樟树市', 3, 1321, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6111, '360983', '360900', '高安市', 3, 1322, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6113, '361001', '361000', '市辖区', 3, 1323, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6115, '361002', '361000', '临川区', 3, 1324, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6117, '361021', '361000', '南城县', 3, 1325, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6119, '361022', '361000', '黎川县', 3, 1326, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6121, '361023', '361000', '南丰县', 3, 1327, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6123, '361024', '361000', '崇仁县', 3, 1328, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6125, '361025', '361000', '乐安县', 3, 1329, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6127, '361026', '361000', '宜黄县', 3, 1330, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6129, '361027', '361000', '金溪县', 3, 1331, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6131, '361028', '361000', '资溪县', 3, 1332, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6133, '361029', '361000', '东乡县', 3, 1333, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6135, '361030', '361000', '广昌县', 3, 1334, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6137, '361101', '361100', '市辖区', 3, 1335, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6139, '361102', '361100', '信州区', 3, 1336, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6141, '361121', '361100', '上饶县', 3, 1338, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6143, '361103', '361100', '广丰区', 3, 1337, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6145, '361123', '361100', '玉山县', 3, 1339, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6147, '361124', '361100', '铅山县', 3, 1340, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6149, '361125', '361100', '横峰县', 3, 1341, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6151, '361126', '361100', '弋阳县', 3, 1342, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6153, '361127', '361100', '余干县', 3, 1343, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6155, '361128', '361100', '鄱阳县', 3, 1344, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6157, '361129', '361100', '万年县', 3, 1345, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6159, '361130', '361100', '婺源县', 3, 1346, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6161, '361181', '361100', '德兴市', 3, 1347, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6163, '370101', '370100', '市辖区', 3, 1348, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6165, '370102', '370100', '历下区', 3, 1349, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6167, '370103', '370100', '市中区', 3, 1350, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6169, '370104', '370100', '槐荫区', 3, 1351, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6171, '370105', '370100', '天桥区', 3, 1352, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6173, '370112', '370100', '历城区', 3, 1353, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6175, '370113', '370100', '长清区', 3, 1354, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6177, '370124', '370100', '平阴县', 3, 1355, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6179, '370125', '370100', '济阳县', 3, 1356, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6181, '370126', '370100', '商河县', 3, 1357, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6183, '370181', '370100', '章丘市', 3, 1358, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6185, '370201', '370200', '市辖区', 3, 1359, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6187, '370202', '370200', '市南区', 3, 1360, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6189, '370203', '370200', '市北区', 3, 1361, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6191, '370211', '370200', '黄岛区', 3, 1363, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6193, '370212', '370200', '崂山区', 3, 1364, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6195, '370213', '370200', '李沧区', 3, 1365, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6197, '370214', '370200', '城阳区', 3, 1366, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6199, '370281', '370200', '胶州市', 3, 1367, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6201, '370282', '370200', '即墨市', 3, 1368, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6203, '370283', '370200', '平度市', 3, 1369, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6205, '370285', '370200', '莱西市', 3, 1371, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6207, '370301', '370300', '市辖区', 3, 1372, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6209, '370302', '370300', '淄川区', 3, 1373, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6211, '370303', '370300', '张店区', 3, 1374, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6213, '370304', '370300', '博山区', 3, 1375, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6215, '370305', '370300', '临淄区', 3, 1376, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6217, '370306', '370300', '周村区', 3, 1377, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6219, '370321', '370300', '桓台县', 3, 1378, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6221, '370322', '370300', '高青县', 3, 1379, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6223, '370323', '370300', '沂源县', 3, 1380, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6225, '370401', '370400', '市辖区', 3, 1381, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6227, '370402', '370400', '市中区', 3, 1382, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6229, '370403', '370400', '薛城区', 3, 1383, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6231, '370404', '370400', '峄城区', 3, 1384, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6233, '370405', '370400', '台儿庄区', 3, 1385, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6235, '370406', '370400', '山亭区', 3, 1386, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6237, '370481', '370400', '滕州市', 3, 1387, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6239, '370501', '370500', '市辖区', 3, 1388, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6241, '370502', '370500', '东营区', 3, 1389, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6243, '370503', '370500', '河口区', 3, 1390, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6245, '370522', '370500', '利津县', 3, 1392, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6247, '370523', '370500', '广饶县', 3, 1393, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6249, '370601', '370600', '市辖区', 3, 1394, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6251, '370602', '370600', '芝罘区', 3, 1395, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6253, '370611', '370600', '福山区', 3, 1396, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6255, '370612', '370600', '牟平区', 3, 1397, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6257, '370613', '370600', '莱山区', 3, 1398, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6259, '370634', '370600', '长岛县', 3, 1399, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6261, '370681', '370600', '龙口市', 3, 1400, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6263, '370682', '370600', '莱阳市', 3, 1401, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6265, '370683', '370600', '莱州市', 3, 1402, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6267, '370684', '370600', '蓬莱市', 3, 1403, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6269, '370685', '370600', '招远市', 3, 1404, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6271, '370686', '370600', '栖霞市', 3, 1405, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6273, '370687', '370600', '海阳市', 3, 1406, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6275, '370701', '370700', '市辖区', 3, 1407, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6277, '370702', '370700', '潍城区', 3, 1408, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6279, '370703', '370700', '寒亭区', 3, 1409, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6281, '370704', '370700', '坊子区', 3, 1410, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6283, '370705', '370700', '奎文区', 3, 1411, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6285, '370724', '370700', '临朐县', 3, 1412, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6287, '370725', '370700', '昌乐县', 3, 1413, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6289, '370781', '370700', '青州市', 3, 1414, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6291, '370782', '370700', '诸城市', 3, 1415, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6293, '370783', '370700', '寿光市', 3, 1416, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6295, '370784', '370700', '安丘市', 3, 1417, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6297, '370785', '370700', '高密市', 3, 1418, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6299, '370786', '370700', '昌邑市', 3, 1419, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6301, '370801', '370800', '市辖区', 3, 1420, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6303, '370811', '370800', '任城区', 3, 1421, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6305, '370826', '370800', '微山县', 3, 1423, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6307, '370827', '370800', '鱼台县', 3, 1424, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6309, '370828', '370800', '金乡县', 3, 1425, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6311, '370829', '370800', '嘉祥县', 3, 1426, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6313, '370830', '370800', '汶上县', 3, 1427, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6315, '370831', '370800', '泗水县', 3, 1428, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6317, '370832', '370800', '梁山县', 3, 1429, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6319, '370881', '370800', '曲阜市', 3, 1430, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6321, '370812', '370800', '兖州区', 3, 1422, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6323, '370883', '370800', '邹城市', 3, 1432, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6325, '370901', '370900', '市辖区', 3, 1433, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6327, '370911', '370900', '岱岳区', 3, 1435, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6329, '370921', '370900', '宁阳县', 3, 1436, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6331, '370923', '370900', '东平县', 3, 1437, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6333, '110101', '110100', '东城区', 3, 1, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6335, '110102', '110100', '西城区', 3, 2, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6337, '110105', '110100', '朝阳区', 3, 5, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6339, '110106', '110100', '丰台区', 3, 6, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6341, '110107', '110100', '石景山区', 3, 7, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6343, '110108', '110100', '海淀区', 3, 8, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6345, '110109', '110100', '门头沟区', 3, 9, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6347, '110111', '110100', '房山区', 3, 10, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6349, '110112', '110100', '通州区', 3, 11, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6351, '110113', '110100', '顺义区', 3, 12, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6353, '110114', '110100', '昌平区', 3, 13, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6355, '110115', '110100', '大兴区', 3, 14, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6357, '110116', '110100', '怀柔区', 3, 15, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6359, '110117', '110100', '平谷区', 3, 16, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6361, '120101', '120100', '和平区', 3, 19, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6363, '120102', '120100', '河东区', 3, 20, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6365, '120103', '120100', '河西区', 3, 21, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6367, '120104', '120100', '南开区', 3, 22, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6369, '120105', '120100', '河北区', 3, 23, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6371, '120106', '120100', '红桥区', 3, 24, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6373, '120110', '120100', '东丽区', 3, 28, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6375, '120111', '120100', '西青区', 3, 29, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6377, '120112', '120100', '津南区', 3, 30, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6379, '120113', '120100', '北辰区', 3, 31, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6381, '120114', '120100', '武清区', 3, 32, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6383, '120115', '120100', '宝坻区', 3, 33, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6385, '120117', '120100', '宁河区', 3, 35, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6387, '120118', '120100', '静海区', 3, 36, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6389, '130101', '130100', '市辖区', 3, 37, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6391, '130102', '130100', '长安区', 3, 38, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6393, '130104', '130100', '桥西区', 3, 40, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6395, '130105', '130100', '新华区', 3, 41, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6397, '130107', '130100', '井陉矿区', 3, 42, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6399, '130108', '130100', '裕华区', 3, 43, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6401, '130121', '130100', '井陉县', 3, 47, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6403, '130123', '130100', '正定县', 3, 48, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6405, '130111', '130100', '栾城区', 3, 46, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6407, '130125', '130100', '行唐县', 3, 49, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6409, '130126', '130100', '灵寿县', 3, 50, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6411, '130127', '130100', '高邑县', 3, 51, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6413, '130128', '130100', '深泽县', 3, 52, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6415, '130129', '130100', '赞皇县', 3, 53, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6417, '130130', '130100', '无极县', 3, 54, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6419, '130131', '130100', '平山县', 3, 55, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6421, '130132', '130100', '元氏县', 3, 56, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6423, '130133', '130100', '赵县', 3, 57, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6425, '130109', '130100', '藁城区', 3, 44, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6427, '130183', '130100', '晋州市', 3, 58, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6429, '130184', '130100', '新乐市', 3, 59, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6431, '130110', '130100', '鹿泉区', 3, 45, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6433, '130201', '130200', '市辖区', 3, 61, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6435, '130202', '130200', '路南区', 3, 62, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6437, '130203', '130200', '路北区', 3, 63, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6439, '130204', '130200', '古冶区', 3, 64, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6441, '130205', '130200', '开平区', 3, 65, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6443, '130207', '130200', '丰南区', 3, 66, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6445, '130208', '130200', '丰润区', 3, 67, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6447, '130223', '130200', '滦县', 3, 69, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6449, '130224', '130200', '滦南县', 3, 70, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6451, '130225', '130200', '乐亭县', 3, 71, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6453, '130227', '130200', '迁西县', 3, 72, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6455, '130229', '130200', '玉田县', 3, 73, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6457, '130209', '130200', '曹妃甸区', 3, 68, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6459, '130281', '130200', '遵化市', 3, 74, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6461, '130283', '130200', '迁安市', 3, 75, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6463, '130301', '130300', '市辖区', 3, 76, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6465, '130302', '130300', '海港区', 3, 77, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6467, '130303', '130300', '山海关区', 3, 78, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6469, '130304', '130300', '北戴河区', 3, 79, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6471, '130321', '130300', '青龙满族自治县', 3, 81, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6473, '130322', '130300', '昌黎县', 3, 82, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6475, '130306', '130300', '抚宁区', 3, 80, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6477, '130324', '130300', '卢龙县', 3, 83, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6479, '130401', '130400', '市辖区', 3, 84, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6481, '130402', '130400', '邯山区', 3, 85, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6483, '130403', '130400', '丛台区', 3, 86, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6485, '130404', '130400', '复兴区', 3, 87, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6487, '130406', '130400', '峰峰矿区', 3, 88, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6489, '130421', '130400', '邯郸县', 3, 89, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6491, '130423', '130400', '临漳县', 3, 90, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6493, '130424', '130400', '成安县', 3, 91, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6495, '130425', '130400', '大名县', 3, 92, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6497, '130426', '130400', '涉县', 3, 93, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6499, '130427', '130400', '磁县', 3, 94, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6501, '130428', '130400', '肥乡县', 3, 95, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6503, '130429', '130400', '永年县', 3, 96, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6505, '130430', '130400', '邱县', 3, 97, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6507, '130431', '130400', '鸡泽县', 3, 98, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6509, '130432', '130400', '广平县', 3, 99, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6511, '130433', '130400', '馆陶县', 3, 100, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6513, '130434', '130400', '魏县', 3, 101, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6515, '130435', '130400', '曲周县', 3, 102, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6517, '130481', '130400', '武安市', 3, 103, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6519, '130501', '130500', '市辖区', 3, 104, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6521, '130502', '130500', '桥东区', 3, 105, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6523, '130503', '130500', '桥西区', 3, 106, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6525, '130521', '130500', '邢台县', 3, 107, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6527, '130522', '130500', '临城县', 3, 108, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6529, '130523', '130500', '内丘县', 3, 109, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6531, '130524', '130500', '柏乡县', 3, 110, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6533, '130525', '130500', '隆尧县', 3, 111, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6535, '130526', '130500', '任县', 3, 112, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6537, '130527', '130500', '南和县', 3, 113, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6539, '130528', '130500', '宁晋县', 3, 114, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6541, '130529', '130500', '巨鹿县', 3, 115, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6543, '130530', '130500', '新河县', 3, 116, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6545, '130531', '130500', '广宗县', 3, 117, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6547, '130532', '130500', '平乡县', 3, 118, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6549, '130533', '130500', '威县', 3, 119, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6551, '130534', '130500', '清河县', 3, 120, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6553, '130535', '130500', '临西县', 3, 121, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6555, '130581', '130500', '南宫市', 3, 122, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6557, '130582', '130500', '沙河市', 3, 123, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6559, '130601', '130600', '市辖区', 3, 124, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6561, '130602', '130600', '竞秀区', 3, 125, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6563, '130606', '130600', '莲池区', 3, 126, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6565, '130607', '130600', '满城区', 3, 128, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6567, '130608', '130600', '清苑区', 3, 129, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6569, '130623', '130600', '涞水县', 3, 131, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6571, '130624', '130600', '阜平县', 3, 132, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6573, '130609', '130600', '徐水区', 3, 130, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6575, '130626', '130600', '定兴县', 3, 133, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6577, '130627', '130600', '唐县', 3, 134, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6579, '130628', '130600', '高阳县', 3, 135, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6581, '130629', '130600', '容城县', 3, 136, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6583, '130630', '130600', '涞源县', 3, 137, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6585, '130631', '130600', '望都县', 3, 138, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6587, '130632', '130600', '安新县', 3, 139, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6589, '130633', '130600', '易县', 3, 140, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6591, '130634', '130600', '曲阳县', 3, 141, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6593, '130635', '130600', '蠡县', 3, 142, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6595, '130636', '130600', '顺平县', 3, 143, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6597, '130637', '130600', '博野县', 3, 144, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6599, '130638', '130600', '雄县', 3, 145, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6601, '130681', '130600', '涿州市', 3, 146, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6603, '130683', '130600', '安国市', 3, 148, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6605, '130684', '130600', '高碑店市', 3, 149, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6607, '130701', '130700', '市辖区', 3, 150, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6609, '130702', '130700', '桥东区', 3, 151, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6611, '130703', '130700', '桥西区', 3, 152, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6613, '130705', '130700', '宣化区', 3, 153, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6615, '130706', '130700', '下花园区', 3, 154, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6617, '130722', '130700', '张北县', 3, 156, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6619, '130723', '130700', '康保县', 3, 157, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6621, '130724', '130700', '沽源县', 3, 158, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6623, '130725', '130700', '尚义县', 3, 159, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6625, '130726', '130700', '蔚县', 3, 160, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6627, '130727', '130700', '阳原县', 3, 161, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6629, '130728', '130700', '怀安县', 3, 162, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6631, '130730', '130700', '怀来县', 3, 164, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6633, '130731', '130700', '涿鹿县', 3, 165, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6635, '130732', '130700', '赤城县', 3, 166, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6637, '130801', '130800', '市辖区', 3, 168, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6639, '130802', '130800', '双桥区', 3, 169, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6641, '130803', '130800', '双滦区', 3, 170, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6643, '130804', '130800', '鹰手营子矿区', 3, 171, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6645, '130821', '130800', '承德县', 3, 172, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6647, '130822', '130800', '兴隆县', 3, 173, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6649, '130823', '130800', '平泉县', 3, 174, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6651, '130824', '130800', '滦平县', 3, 175, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6653, '130825', '130800', '隆化县', 3, 176, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6655, '130826', '130800', '丰宁满族自治县', 3, 177, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6657, '130827', '130800', '宽城满族自治县', 3, 178, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6659, '130828', '130800', '围场满族蒙古族自治县', 3, 179, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6661, '130901', '130900', '市辖区', 3, 180, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6663, '130902', '130900', '新华区', 3, 181, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6665, '130903', '130900', '运河区', 3, 182, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6667, '130921', '130900', '沧县', 3, 183, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6669, '130922', '130900', '青县', 3, 184, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6671, '130923', '130900', '东光县', 3, 185, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6673, '130924', '130900', '海兴县', 3, 186, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6675, '130925', '130900', '盐山县', 3, 187, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6677, '130926', '130900', '肃宁县', 3, 188, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6679, '130927', '130900', '南皮县', 3, 189, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6681, '130928', '130900', '吴桥县', 3, 190, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6683, '130929', '130900', '献县', 3, 191, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6685, '130930', '130900', '孟村回族自治县', 3, 192, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6687, '130981', '130900', '泊头市', 3, 193, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6689, '130982', '130900', '任丘市', 3, 194, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6691, '130983', '130900', '黄骅市', 3, 195, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6693, '130984', '130900', '河间市', 3, 196, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6695, '131001', '131000', '市辖区', 3, 197, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6697, '131002', '131000', '安次区', 3, 198, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6699, '131003', '131000', '广阳区', 3, 199, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6701, '131022', '131000', '固安县', 3, 200, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6703, '131023', '131000', '永清县', 3, 201, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6705, '131024', '131000', '香河县', 3, 202, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6707, '131025', '131000', '大城县', 3, 203, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6709, '131026', '131000', '文安县', 3, 204, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6711, '131028', '131000', '大厂回族自治县', 3, 205, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6713, '131081', '131000', '霸州市', 3, 206, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6715, '131082', '131000', '三河市', 3, 207, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6717, '131101', '131100', '市辖区', 3, 208, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6719, '131102', '131100', '桃城区', 3, 209, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6721, '131121', '131100', '枣强县', 3, 210, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6723, '131122', '131100', '武邑县', 3, 211, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6725, '131123', '131100', '武强县', 3, 212, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6727, '131124', '131100', '饶阳县', 3, 213, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6729, '131125', '131100', '安平县', 3, 214, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6731, '131126', '131100', '故城县', 3, 215, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6733, '131127', '131100', '景县', 3, 216, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6735, '131128', '131100', '阜城县', 3, 217, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6737, '131182', '131100', '深州市', 3, 219, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6739, '140101', '140100', '市辖区', 3, 220, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6741, '140105', '140100', '小店区', 3, 221, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6743, '140106', '140100', '迎泽区', 3, 222, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6745, '140107', '140100', '杏花岭区', 3, 223, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6747, '140108', '140100', '尖草坪区', 3, 224, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6749, '140109', '140100', '万柏林区', 3, 225, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6751, '140110', '140100', '晋源区', 3, 226, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6753, '140121', '140100', '清徐县', 3, 227, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6755, '140122', '140100', '阳曲县', 3, 228, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6757, '140123', '140100', '娄烦县', 3, 229, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6759, '140181', '140100', '古交市', 3, 230, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6761, '140201', '140200', '市辖区', 3, 231, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6763, '140202', '140200', '城区', 3, 232, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6765, '140203', '140200', '矿区', 3, 233, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6767, '120116', '120100', '滨海新区', 3, 34, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6769, '370902', '370900', '泰山区', 3, 1434, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6771, '139000', '130000', '省直辖县级行政区划', 2, 16, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6773, '139001', '139000', '定州市', 3, 10, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6775, '139002', '139000', '辛集市', 3, 11, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6777, '150601', '150600', '市辖区', 3, 395, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6779, '150703', '150700', '扎赉诺尔区', 3, 406, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6781, '150722', '150700', '莫力达瓦达斡尔族自治旗', 3, 408, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6783, '211324', '211300', '喀喇沁左翼蒙古族自治县', 3, 563, 0, NULL, '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6785, '220113', '220100', '九台区', 3, 580, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6787, '220721', '220700', '前郭尔罗斯蒙古族自治县', 3, 623, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6789, '340124', '340100', '庐江县', 3, 1030, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6791, '340181', '340100', '巢湖市', 3, 1031, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6793, '340225', '340200', '无为县', 3, 1038, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6795, '340522', '340500', '含山县', 3, 1058, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6797, '340523', '340500', '和县', 3, 1059, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6799, '360482', '360400', '共青城市', 3, 1272, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6801, '419000', '410000', '省直辖县级行政区划', 2, 172, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6803, '419001', '419000', '济源市', 3, 10, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6805, '421321', '421300', '随县', 3, 1782, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6807, '450903', '450900', '福绵区', 3, 2143, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6809, '460202', '460200', '海棠区', 3, 2199, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6811, '460203', '460200', '吉阳区', 3, 2200, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6813, '460204', '460200', '天涯区', 3, 2201, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6815, '460205', '460200', '崖州区', 3, 2202, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6817, '460300', '460000', '三沙市', 2, 237, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6819, '460321', '460300', '西沙群岛', 3, 10, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6821, '460322', '460300', '南沙群岛', 3, 11, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6823, '460323', '460300', '中沙群岛的岛礁及其海域', 3, 12, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6825, '500116', '500100', '江津区', 3, 2233, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6827, '500117', '500100', '合川区', 3, 2234, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6829, '500118', '500100', '永川区', 3, 2235, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6831, '500119', '500100', '南川区', 3, 2236, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6833, '500120', '500100', '璧山区', 3, 2237, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6835, '500151', '500100', '铜梁区', 3, 2238, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6837, '500152', '500100', '潼南区', 3, 2239, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6839, '500153', '500100', '荣昌区', 3, 2240, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6841, '511603', '511600', '前锋区', 3, 2378, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6843, '511903', '511900', '恩阳区', 3, 2401, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6845, '520525', '520500', '纳雍县', 3, 2518, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6847, '520526', '520500', '威宁彝族回族苗族自治县', 3, 2519, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6849, '520621', '520600', '江口县', 3, 2497, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6851, '522300', '520000', '黔西南布依族苗族自治州', 2, 268, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6853, '522301', '522300', '兴义市', 3, 10, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6855, '522322', '522300', '兴仁县', 3, 11, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6857, '522323', '522300', '普安县', 3, 12, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6859, '522324', '522300', '晴隆县', 3, 13, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6861, '522325', '522300', '贞丰县', 3, 14, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6863, '522326', '522300', '望谟县', 3, 15, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6865, '522327', '522300', '册亨县', 3, 16, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6867, '522328', '522300', '安龙县', 3, 17, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6869, '530428', '530400', '元江哈尼族彝族傣族自治县', 3, 2582, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6871, '530825', '530800', '镇沅彝族哈尼族拉祜族自治县', 3, 1613, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6873, '530827', '530800', '孟连傣族拉祜族佤族自治县', 3, 2615, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6875, '530925', '530900', '双江拉祜族佤族布朗族傣族自治县', 3, 2624, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6877, '532504', '532500', '弥勒市', 3, 2640, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6879, '542431', '542400', '双湖县', 3, 2745, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6881, '610602', '610600', '宝塔区', 3, 2819, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6883, '622927', '622900', '积石山保安族东乡族撒拉族自治县', 3, 2965, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6885, '640303', '640300', '红寺堡区', 3, 3031, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6887, '652702', '652700', '阿拉山口市', 3, 3073, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6889, '653000', '650000', '克孜勒苏柯尔克孜自治州', 2, 339, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6891, '653001', '653000', '阿图什市', 3, 10, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6893, '653022', '653000', '阿克陶县', 3, 11, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6895, '653023', '653000', '阿合奇县', 3, 12, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6897, '653024', '653000', '乌恰县', 3, 13, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6899, '653131', '653100', '塔什库尔干塔吉克自治县', 3, 3108, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6901, '654004', '654000', '霍尔果斯市', 3, 3118, 0, '', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6903, '320213', '320200', '梁溪区', 3, 825, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6905, '320214', '320200', '新吴区', 3, 826, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6907, '500154', '500100', '开州区', 3, 2241, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6909, '110118', '110100', '密云区', 3, 17, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6911, '110119', '110100', '延庆区', 3, 18, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6913, '120119', '120100', '蓟州区', 3, 37, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6915, '130708', '130700', '万全区', 3, 167, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6917, '130709', '130700', '崇礼区', 3, 168, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6919, '131103', '131100', '冀州区', 3, 220, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6921, '150603', '150600', '康巴什区', 3, 404, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6923, '210115', '210100', '辽中区', 3, 473, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6925, '210214', '210200', '普兰店区', 3, 484, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6927, '211104', '211100', '大洼区', 3, 550, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6929, '230883', '230800', '抚远市', 3, 743, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6931, '231086', '231000', '东宁市', 3, 762, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6933, '310151', '310100', '崇明区', 3, 801, 0, '2016.12.维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6935, '320812', '320800', '清江浦区', 3, 883, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6937, '320813', '320800', '洪泽区', 3, 884, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6939, '340722', '340700', '枞阳县', 3, 1068, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6941, '340705', '340700', '铜官区', 3, 1064, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6943, '340706', '340700', '义安区', 3, 1065, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6945, '341504', '341500', '叶集区', 3, 1126, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6947, '340422', '340400', '寿县', 3, 1053, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6949, '360402', '360400', '濂溪区', 3, 1273, 0, '2016.12维护 庐山区改为濂溪区 ', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6951, '360483', '360400', '庐山市', 3, 1274, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6953, '370505', '370500', '垦利区', 3, 1394, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6955, '371703', '371700', '定陶区', 3, 1505, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6957, '411203', '411200', '陕州区', 3, 1624, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6959, '450206', '450200', '柳江区', 3, 2094, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6961, '451103', '451100', '平桂区', 3, 2166, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6963, '510116', '510100', '双流区', 3, 2278, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6965, '510705', '510700', '安州区', 3, 2316, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6967, '510185', '510100', '简阳市', 3, 2279, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6969, '513201', '513200', '马尔康市', 3, 2422, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6971, '520304', '520300', '播州区', 3, 2487, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6973, '530303', '530300', '沾益区', 3, 2573, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6975, '530403', '530400', '江川区', 3, 2583, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6977, '533301', '533300', '泸水市', 3, 2682, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6979, '540103', '540100', '堆龙德庆区', 3, 2694, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6981, '540500', '540000', '山南市', 2, 291, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6983, '540502', '540500', '乃东区', 3, 10, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6985, '540521', '540500', '扎囊县', 3, 11, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6987, '540522', '540500', '贡嘎县', 3, 12, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6989, '540523', '540500', '桑日县', 3, 13, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6991, '540524', '540500', '琼结县', 3, 14, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6993, '540525', '540500', '曲松县', 3, 15, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6995, '540526', '540500', '措美县', 3, 16, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6997, '540527', '540500', '洛扎县', 3, 17, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (6999, '540528', '540500', '加查县', 3, 18, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7001, '540529', '540500', '隆子县', 3, 19, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7003, '540530', '540500', '错那县', 3, 20, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7005, '540531', '540500', '浪卡子县', 3, 21, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7007, '610503', '610500', '华州区', 3, 2818, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7009, '610603', '610600', '安塞区', 3, 2832, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7011, '610803', '610800', '横山区', 3, 2857, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7013, '650500', '650000', '哈密市', 2, 346, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7015, '650502', '650500', '伊州区', 3, 10, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7017, '650521', '650500', '巴里坤哈萨克自治县', 3, 11, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7019, '650522', '650500', '伊吾县', 3, 12, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7021, '654004', '654000', '霍尔果斯市', 3, 3127, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7023, '659005', '659000', '北屯市', 3, 3145, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7025, '659006', '659000', '铁门关市', 3, 3146, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7027, '659007', '659000', '双河市', 3, 3147, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7029, '659008', '659000', '可克达拉市', 3, 3148, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');
INSERT INTO `sys_area` VALUES (7031, '659009', '659000', '昆玉市', 3, 3149, 0, '2016.12维护', '2018-03-14 00:00:00', '2018-03-14 00:00:00');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `config_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一标识',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值',
  `config_remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `user_id_create` bigint(20) NOT NULL COMMENT '创建人',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL COMMENT '状态 0 禁用 1 可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '21', '12', '12', 1, '2020-05-07 11:17:22', '2020-05-07 11:17:22', 1);
INSERT INTO `sys_config` VALUES (2, '2122', '2121', '2121', 1, '2020-05-12 21:45:59', '2020-05-12 21:41:05', 1);

-- ----------------------------
-- Table structure for sys_landing_records
-- ----------------------------
DROP TABLE IF EXISTS `sys_landing_records`;
CREATE TABLE `sys_landing_records`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID',
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近登录时间',
  `place` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最近登录地点',
  `ip` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最近登录IP',
  `login_way` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6040 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户登录日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_landing_records
-- ----------------------------
INSERT INTO `sys_landing_records` VALUES (129, 43, '2018-03-26 11:42:36', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (131, 1, '2018-03-30 10:24:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (133, 1, '2018-03-30 10:25:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (135, 155, '2018-04-10 15:39:31', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (137, 155, '2018-04-10 15:39:51', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (139, 155, '2018-04-10 15:40:09', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (141, 155, '2018-04-10 15:42:08', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (143, 155, '2018-04-10 15:42:23', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (145, 155, '2018-04-10 15:46:54', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (147, 43, '2018-04-10 15:47:33', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (149, 43, '2018-04-10 15:48:07', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (151, 43, '2018-04-10 15:48:16', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (153, 43, '2018-04-10 15:48:53', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (155, 43, '2018-04-10 15:55:01', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (157, 43, '2018-04-10 15:55:18', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (159, 1, '2018-04-10 15:59:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (161, 1, '2018-04-10 15:59:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (163, 43, '2018-04-10 16:00:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (165, 43, '2018-04-10 16:01:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (167, 43, '2018-04-10 16:06:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (169, 43, '2018-04-10 16:06:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (171, 43, '2018-04-10 16:07:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (173, 43, '2018-04-10 16:10:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (175, 43, '2018-04-10 16:11:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (177, 1, '2018-04-10 16:22:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (179, 43, '2018-04-10 16:22:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (181, 43, '2018-04-10 16:23:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (183, 43, '2018-04-10 16:35:13', '未知区域', '0:0:0:0:0:0:0:1', '手机');
INSERT INTO `sys_landing_records` VALUES (185, 1, '2018-04-23 10:45:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (187, 43, '2018-04-26 14:09:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (189, 43, '2018-04-26 14:59:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (191, 155, '2018-04-27 14:59:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (193, 1, '2018-05-04 16:46:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (195, 297, '2018-05-04 16:49:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (197, 297, '2018-05-04 16:50:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (199, 1, '2018-05-07 11:03:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (201, 1, '2018-05-07 11:25:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (203, 1, '2018-05-07 11:43:40', 'XXXX', '102.136.60.115', '电脑');
INSERT INTO `sys_landing_records` VALUES (205, 1, '2018-05-07 13:29:02', '未知区域', '192.168.1.115', '电脑');
INSERT INTO `sys_landing_records` VALUES (207, 1, '2018-05-07 13:34:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (209, 1, '2018-05-07 14:32:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (211, 1, '2018-05-07 14:48:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (213, 1, '2018-05-07 15:10:16', '未知区域', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (215, 1, '2018-05-07 15:40:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (217, 1, '2018-05-07 16:30:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (219, 1, '2018-05-07 16:39:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (221, 1, '2018-05-07 17:04:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (223, 1, '2018-05-07 17:22:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (225, 1, '2018-05-07 17:31:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (227, 1, '2018-05-07 17:39:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (229, 1, '2018-05-07 17:40:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (231, 1, '2018-05-07 17:46:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (233, 1, '2018-05-07 17:56:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (235, 1, '2018-05-08 09:10:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (237, 1, '2018-05-08 09:21:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (239, 1, '2018-05-08 09:26:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (241, 1, '2018-05-08 09:37:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (243, 1, '2018-05-08 09:42:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (245, 1, '2018-05-08 09:51:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (247, 1, '2018-05-08 10:03:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (249, 1, '2018-05-08 10:05:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (251, 1, '2018-05-08 10:12:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (253, 1, '2018-05-08 10:19:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (255, 1, '2018-05-08 10:23:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (257, 1, '2018-05-08 10:25:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (259, 1, '2018-05-08 10:30:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (261, 1, '2018-05-08 10:43:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (263, 1, '2018-05-08 10:47:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (265, 13, '2018-05-08 10:48:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (267, 13, '2018-05-08 10:48:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (269, 1, '2018-05-08 10:50:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (271, 1, '2018-05-08 10:51:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (273, 13, '2018-05-08 11:24:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (275, 1, '2018-05-08 11:25:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (277, 13, '2018-05-08 11:26:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (279, 1, '2018-05-08 12:24:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (281, 1, '2018-05-08 13:12:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (283, 1, '2018-05-08 13:13:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (285, 13, '2018-05-08 13:37:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (287, 1, '2018-05-08 14:40:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (289, 1, '2018-05-08 14:43:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (291, 1, '2018-05-08 15:25:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (293, 1, '2018-05-08 16:15:04', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (295, 1, '2018-05-08 16:42:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (297, 1, '2018-05-08 17:17:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (299, 1, '2018-05-08 17:28:59', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (301, 1, '2018-05-08 17:53:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (303, 1, '2018-05-08 18:11:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (305, 13, '2018-05-09 09:07:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (307, 1, '2018-05-09 09:19:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (309, 1, '2018-05-09 09:24:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (311, 13, '2018-05-09 09:26:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (313, 1, '2018-05-09 10:08:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.115', '电脑');
INSERT INTO `sys_landing_records` VALUES (315, 1, '2018-05-09 10:43:08', '内网IP内网IP', '192.168.1.64', '电脑');
INSERT INTO `sys_landing_records` VALUES (317, 1, '2018-05-09 11:11:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (319, 13, '2018-05-09 11:38:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (321, 1, '2018-05-09 11:40:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (323, 1, '2018-05-09 13:21:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (325, 1, '2018-05-09 13:31:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (327, 1, '2018-05-09 13:43:57', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (329, 13, '2018-05-09 13:44:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (331, 1, '2018-05-09 13:46:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (333, 1, '2018-05-09 13:52:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (335, 1, '2018-05-09 13:52:52', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (337, 1, '2018-05-09 14:12:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (339, 1, '2018-05-09 14:15:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (341, 1, '2018-05-09 14:29:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (343, 1, '2018-05-09 14:30:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (345, 1, '2018-05-09 14:30:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (347, 1, '2018-05-09 14:38:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (349, 1, '2018-05-09 14:38:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (351, 1, '2018-05-09 14:44:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (353, 13, '2018-05-09 14:47:22', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (355, 1, '2018-05-09 14:54:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (357, 13, '2018-05-09 15:07:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (359, 1, '2018-05-09 15:07:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (361, 29, '2018-05-09 15:12:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (363, 1, '2018-05-09 15:13:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (365, 1, '2018-05-09 15:18:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (367, 1, '2018-05-09 15:31:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (369, 1, '2018-05-09 15:39:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (371, 1, '2018-05-09 15:42:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (373, 1, '2018-05-09 15:44:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (375, 1, '2018-05-09 15:51:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (377, 1, '2018-05-09 16:08:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (379, 1, '2018-05-09 16:13:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (381, 1, '2018-05-09 16:17:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (383, 1, '2018-05-09 16:18:14', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (385, 1, '2018-05-09 16:21:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (387, 1, '2018-05-09 16:25:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (389, 1, '2018-05-09 16:26:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (391, 1, '2018-05-09 16:41:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (393, 1, '2018-05-09 16:50:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (395, 1, '2018-05-09 16:56:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (397, 1, '2018-05-09 17:00:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (399, 13, '2018-05-09 17:17:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (401, 1, '2018-05-09 17:17:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (403, 1, '2018-05-09 17:22:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (405, 1, '2018-05-10 09:07:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (407, 13, '2018-05-10 09:20:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (409, 1, '2018-05-10 09:20:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (411, 1, '2018-05-10 11:29:58', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (413, 1, '2018-05-10 13:13:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (415, 1, '2018-05-10 13:24:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (417, 1, '2018-05-10 14:40:39', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (419, 1, '2018-05-10 14:40:39', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (421, 1, '2018-05-10 16:14:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (423, 1, '2018-05-10 16:35:22', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (425, 1, '2018-05-10 16:41:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (427, 1, '2018-05-10 17:20:44', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (429, 1, '2018-05-10 17:23:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (431, 1, '2018-05-10 17:23:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (433, 1, '2018-05-10 17:42:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (435, 1, '2018-05-10 17:46:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (437, 1, '2018-05-11 09:08:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (439, 1, '2018-05-11 09:12:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (441, 1, '2018-05-11 09:26:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (443, 1, '2018-05-11 10:10:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (445, 1, '2018-05-11 10:18:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (447, 1, '2018-05-11 11:01:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (449, 1, '2018-05-11 13:19:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (451, 1, '2018-05-11 13:21:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (453, 1, '2018-05-11 14:00:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (455, 1, '2018-05-11 14:50:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (457, 1, '2018-05-11 14:50:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (459, 1, '2018-05-11 14:59:22', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (461, 1, '2018-05-11 15:24:54', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (463, 1, '2018-05-11 15:40:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (465, 1, '2018-05-11 15:45:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (467, 1, '2018-05-11 15:54:19', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (469, 1, '2018-05-11 16:46:57', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (471, 1, '2018-05-11 16:53:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (473, 1, '2018-05-11 17:07:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (475, 1, '2018-05-11 17:50:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (477, 1, '2018-05-14 09:13:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (479, 1, '2018-05-14 09:35:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (481, 1, '2018-05-14 09:48:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (483, 1, '2018-05-14 10:00:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (485, 1, '2018-05-14 10:04:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (487, 1, '2018-05-14 10:10:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (489, 1, '2018-05-14 10:16:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (491, 1, '2018-05-14 10:18:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (493, 1, '2018-05-14 10:29:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (495, 1, '2018-05-14 10:33:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (497, 1, '2018-05-14 10:35:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (499, 1, '2018-05-14 10:38:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (501, 1, '2018-05-14 10:41:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (503, 1, '2018-05-14 10:43:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (505, 1, '2018-05-14 10:45:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (507, 1, '2018-05-14 10:48:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (509, 1, '2018-05-14 10:53:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (511, 1, '2018-05-14 10:53:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (513, 1, '2018-05-14 11:00:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (515, 1, '2018-05-14 11:01:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (517, 1, '2018-05-14 11:06:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (519, 1, '2018-05-14 11:07:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (521, 1, '2018-05-14 11:11:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (523, 1, '2018-05-14 11:16:26', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (525, 1, '2018-05-14 11:16:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (527, 1, '2018-05-14 11:17:59', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (529, 1, '2018-05-14 11:18:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (531, 1, '2018-05-14 11:20:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (533, 1, '2018-05-14 11:21:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (535, 1, '2018-05-14 11:23:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (537, 1, '2018-05-14 11:26:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (539, 1, '2018-05-14 11:28:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (541, 1, '2018-05-14 11:32:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (543, 1, '2018-05-14 11:32:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (545, 1, '2018-05-14 11:35:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (547, 1, '2018-05-14 11:44:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (549, 1, '2018-05-14 11:49:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (551, 1, '2018-05-14 13:10:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (553, 1, '2018-05-14 13:17:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (555, 1, '2018-05-14 13:28:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (557, 1, '2018-05-14 13:28:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (559, 2, '2018-05-14 13:28:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (561, 2, '2018-05-14 13:29:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (563, 2, '2018-05-14 13:29:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (565, 1, '2018-05-14 13:30:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (567, 31, '2018-05-14 13:34:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (569, 31, '2018-05-14 13:34:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (571, 1, '2018-05-14 13:34:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (573, 35, '2018-05-14 13:37:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (575, 35, '2018-05-14 13:38:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (577, 31, '2018-05-14 13:38:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (579, 1, '2018-05-14 14:00:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (581, 1, '2018-05-14 14:00:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (583, 1, '2018-05-14 14:59:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (585, 1, '2018-05-14 15:12:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (587, 1, '2018-05-14 15:16:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (589, 1, '2018-05-14 15:27:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (591, 1, '2018-05-14 15:29:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (593, 1, '2018-05-14 15:34:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (595, 1, '2018-05-14 15:41:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (597, 1, '2018-05-14 15:48:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (599, 1, '2018-05-14 15:50:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (601, 1, '2018-05-14 15:52:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (603, 1, '2018-05-14 15:55:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (605, 1, '2018-05-14 16:13:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (607, 1, '2018-05-14 16:23:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (609, 1, '2018-05-14 17:04:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (611, 1, '2018-05-14 17:05:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (613, 23, '2018-05-14 17:07:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (615, 23, '2018-05-14 17:07:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (617, 1, '2018-05-14 17:07:58', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (619, 1, '2018-05-14 17:15:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (621, 1, '2018-05-14 17:17:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (623, 1, '2018-05-14 17:28:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (625, 1, '2018-05-14 17:38:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (627, 1, '2018-05-14 17:41:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (629, 1, '2018-05-14 17:52:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (631, 1, '2018-05-14 17:57:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (633, 1, '2018-05-15 09:11:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (635, 23, '2018-05-15 09:11:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (637, 1, '2018-05-15 09:14:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (639, 1, '2018-05-15 09:16:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (641, 1, '2018-05-15 09:18:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (643, 1, '2018-05-15 09:18:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (645, 1, '2018-05-15 09:23:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (647, 1, '2018-05-15 10:07:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (649, 1, '2018-05-15 10:12:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (651, 1, '2018-05-15 10:21:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (653, 1, '2018-05-15 10:23:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (655, 1, '2018-05-15 10:38:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (657, 1, '2018-05-15 10:39:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (659, 1, '2018-05-15 10:46:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (661, 1, '2018-05-15 10:47:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (663, 1, '2018-05-15 10:48:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (665, 1, '2018-05-15 10:55:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (667, 1, '2018-05-15 11:03:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (669, 1, '2018-05-15 11:06:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (671, 1, '2018-05-15 11:13:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (673, 1, '2018-05-15 11:19:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (675, 1, '2018-05-15 11:20:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (677, 1, '2018-05-15 11:38:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (679, 1, '2018-05-15 11:43:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (681, 1, '2018-05-15 11:43:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (683, 1, '2018-05-15 11:48:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (685, 1, '2018-05-15 12:09:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (687, 1, '2018-05-15 12:09:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (689, 1, '2018-05-15 12:09:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (691, 1, '2018-05-15 12:16:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (693, 1, '2018-05-15 12:18:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (695, 1, '2018-05-15 12:39:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (697, 1, '2018-05-15 12:46:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (699, 1, '2018-05-15 12:48:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (701, 1, '2018-05-15 12:49:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (703, 1, '2018-05-15 13:18:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (705, 1, '2018-05-15 13:26:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (707, 1, '2018-05-15 13:28:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (709, 1, '2018-05-15 13:30:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (711, 1, '2018-05-15 13:33:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (713, 1, '2018-05-15 13:39:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (715, 1, '2018-05-15 13:40:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (717, 1, '2018-05-15 13:40:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (719, 1, '2018-05-15 13:42:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (721, 1, '2018-05-15 13:45:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (723, 1, '2018-05-15 13:48:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (725, 1, '2018-05-15 13:49:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (727, 1, '2018-05-15 13:50:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (729, 1, '2018-05-15 13:51:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (731, 1, '2018-05-15 13:57:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (733, 1, '2018-05-15 13:59:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (735, 1, '2018-05-15 14:01:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (737, 1, '2018-05-15 14:02:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (739, 1, '2018-05-15 14:02:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (741, 1, '2018-05-15 14:10:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (743, 1, '2018-05-15 14:14:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (745, 1, '2018-05-15 14:15:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (747, 1, '2018-05-15 14:17:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (749, 1, '2018-05-15 14:19:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (751, 1, '2018-05-15 14:20:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (753, 1, '2018-05-15 14:21:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (755, 1, '2018-05-15 14:22:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (757, 1, '2018-05-15 14:26:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (759, 1, '2018-05-15 14:30:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (761, 1, '2018-05-15 14:31:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (763, 1, '2018-05-15 14:32:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (765, 1, '2018-05-15 14:33:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (767, 1, '2018-05-15 14:34:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (769, 1, '2018-05-15 16:26:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (771, 1, '2018-05-15 17:08:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (773, 1, '2018-05-15 17:25:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (775, 1, '2018-05-15 17:32:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (777, 1, '2018-05-15 17:39:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (779, 1, '2018-05-15 17:43:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (781, 1, '2018-05-15 18:04:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (783, 1, '2018-05-16 08:59:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (785, 1, '2018-05-16 09:06:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (787, 1, '2018-05-16 09:13:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (789, 1, '2018-05-16 09:18:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (791, 1, '2018-05-16 09:56:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (793, 1, '2018-05-16 09:57:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (795, 1, '2018-05-16 10:06:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (797, 1, '2018-05-16 10:15:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (799, 1, '2018-05-16 10:17:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (801, 1, '2018-05-16 10:24:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (803, 1, '2018-05-16 10:26:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (805, 1, '2018-05-16 10:29:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (807, 1, '2018-05-16 10:42:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (809, 1, '2018-05-16 10:43:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (811, 1, '2018-05-16 10:45:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (813, 1, '2018-05-16 10:50:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (815, 1, '2018-05-16 10:51:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (817, 1, '2018-05-16 10:53:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (819, 1, '2018-05-16 10:54:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (821, 1, '2018-05-16 10:57:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (823, 1, '2018-05-16 11:08:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (825, 1, '2018-05-16 11:10:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (827, 1, '2018-05-16 11:14:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (829, 1, '2018-05-16 11:16:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (831, 1, '2018-05-16 11:19:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (833, 1, '2018-05-16 11:22:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (835, 1, '2018-05-16 11:28:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (837, 1, '2018-05-16 11:34:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (839, 1, '2018-05-16 13:16:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (841, 1, '2018-05-16 13:23:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (843, 1, '2018-05-16 13:31:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (845, 1, '2018-05-16 13:32:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (847, 1, '2018-05-16 13:36:21', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (849, 1, '2018-05-16 13:44:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (851, 1, '2018-05-16 13:44:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (853, 1, '2018-05-16 14:07:46', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (855, 1, '2018-05-16 14:51:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (857, 1, '2018-05-16 15:14:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (859, 1, '2018-05-16 15:23:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (861, 1, '2018-05-16 15:25:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (863, 1, '2018-05-16 15:29:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (865, 1, '2018-05-16 15:33:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (867, 1, '2018-05-16 15:40:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (869, 1, '2018-05-16 15:46:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (871, 1, '2018-05-16 15:48:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (873, 1, '2018-05-16 15:51:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (875, 1, '2018-05-16 15:56:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (877, 1, '2018-05-16 15:57:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (879, 1, '2018-05-16 15:57:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (881, 1, '2018-05-16 15:58:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (883, 1, '2018-05-16 15:59:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (885, 1, '2018-05-16 16:01:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (887, 1, '2018-05-16 16:01:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (889, 1, '2018-05-16 16:17:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (891, 1, '2018-05-16 16:19:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (893, 1, '2018-05-16 16:21:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (895, 1, '2018-05-16 16:22:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (897, 1, '2018-05-16 16:49:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (899, 1, '2018-05-16 17:12:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (901, 1, '2018-05-16 17:59:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (903, 1, '2018-05-16 18:00:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (905, 1, '2018-05-16 18:04:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (907, 1, '2018-05-16 18:06:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (909, 1, '2018-05-17 09:04:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (911, 1, '2018-05-17 09:09:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (913, 1, '2018-05-17 09:14:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (915, 1, '2018-05-17 09:35:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (917, 1, '2018-05-17 09:50:50', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (919, 1, '2018-05-17 10:25:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (921, 1, '2018-05-17 10:37:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (923, 1, '2018-05-17 11:10:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (925, 1, '2018-05-17 11:12:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (927, 1, '2018-05-17 11:16:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (929, 1, '2018-05-17 11:18:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (931, 1, '2018-05-17 11:18:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (933, 1, '2018-05-17 11:20:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (935, 1, '2018-05-17 11:21:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (937, 1, '2018-05-17 11:26:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (939, 1, '2018-05-17 11:33:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (941, 1, '2018-05-17 11:36:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (943, 1, '2018-05-17 11:37:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (945, 1, '2018-05-17 13:29:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (947, 1, '2018-05-17 13:30:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (949, 1, '2018-05-17 13:30:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (951, 1, '2018-05-17 13:36:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (953, 1, '2018-05-17 13:46:42', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (955, 1, '2018-05-17 14:26:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (957, 1, '2018-05-17 14:37:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (959, 1, '2018-05-17 14:39:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (961, 1, '2018-05-17 14:39:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (963, 1, '2018-05-17 14:40:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (965, 1, '2018-05-17 15:23:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (967, 1, '2018-05-17 15:31:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (969, 31, '2018-05-17 15:32:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (971, 1, '2018-05-17 15:33:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (973, 1, '2018-05-17 15:33:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (975, 31, '2018-05-17 15:35:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (977, 31, '2018-05-17 15:38:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (979, 31, '2018-05-17 15:39:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (981, 31, '2018-05-17 15:41:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (983, 1, '2018-05-17 15:42:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (985, 1, '2018-05-17 15:47:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (987, 1, '2018-05-17 15:48:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (989, 1, '2018-05-17 15:51:43', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (991, 1, '2018-05-17 16:05:37', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (993, 1, '2018-05-17 16:07:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (995, 1, '2018-05-17 16:07:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (997, 1, '2018-05-17 16:10:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (999, 1, '2018-05-17 16:12:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1001, 1, '2018-05-17 16:45:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1003, 1, '2018-05-17 16:53:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1005, 1, '2018-05-17 16:55:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1007, 1, '2018-05-17 16:59:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1009, 1, '2018-05-17 17:02:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1011, 1, '2018-05-17 17:16:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1013, 1, '2018-05-17 17:16:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1015, 1, '2018-05-17 17:34:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1017, 1, '2018-05-17 17:41:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1019, 1, '2018-05-17 17:43:19', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1021, 1, '2018-05-17 17:43:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1023, 1, '2018-05-17 17:50:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1025, 1, '2018-05-17 17:55:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1027, 1, '2018-05-17 18:02:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1029, 1, '2018-05-17 18:03:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1031, 1, '2018-05-17 18:06:37', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1033, 1, '2018-05-17 18:10:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1035, 1, '2018-05-17 18:15:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1037, 1, '2018-05-17 18:17:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1039, 1, '2018-05-17 18:18:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1041, 1, '2018-05-17 18:24:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1043, 1, '2018-05-17 18:29:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1045, 1, '2018-05-17 18:31:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1047, 1, '2018-05-18 09:07:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1049, 1, '2018-05-18 09:09:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1051, 1, '2018-05-18 09:17:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1053, 1, '2018-05-18 09:21:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1055, 1, '2018-05-18 09:27:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1057, 1, '2018-05-18 09:28:56', 'XXXX', '102.136.60.115', '电脑');
INSERT INTO `sys_landing_records` VALUES (1059, 1, '2018-05-18 09:29:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1061, 1, '2018-05-18 09:30:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1063, 1, '2018-05-18 09:30:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1065, 1, '2018-05-18 09:30:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1067, 1, '2018-05-18 09:32:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1069, 1, '2018-05-18 09:35:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1071, 1, '2018-05-18 09:38:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1073, 1, '2018-05-18 09:45:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1075, 1, '2018-05-18 09:48:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1077, 1, '2018-05-18 09:52:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1079, 1, '2018-05-18 09:54:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1081, 1, '2018-05-18 09:55:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1083, 1, '2018-05-18 09:58:54', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1085, 1, '2018-05-18 09:59:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1087, 1, '2018-05-18 10:02:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1089, 1, '2018-05-18 10:04:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1091, 1, '2018-05-18 10:07:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1093, 1, '2018-05-18 10:10:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1095, 1, '2018-05-18 10:23:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1097, 1, '2018-05-18 10:27:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1099, 1, '2018-05-18 10:48:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1101, 1, '2018-05-18 11:08:14', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1103, 1, '2018-05-18 11:18:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1105, 1, '2018-05-18 11:21:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1107, 1, '2018-05-18 11:22:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1109, 1, '2018-05-18 11:23:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1111, 1, '2018-05-18 11:25:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1113, 1, '2018-05-18 11:27:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1115, 1, '2018-05-18 11:29:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1117, 1, '2018-05-18 11:33:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1119, 1, '2018-05-18 11:37:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1121, 1, '2018-05-18 11:38:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1123, 1, '2018-05-18 11:38:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1125, 1, '2018-05-18 11:42:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1127, 1, '2018-05-18 11:46:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1129, 1, '2018-05-18 11:47:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1131, 1, '2018-05-18 11:49:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1133, 1, '2018-05-18 11:49:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1135, 1, '2018-05-18 11:54:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1137, 1, '2018-05-18 12:12:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1139, 1, '2018-05-18 12:15:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1141, 1, '2018-05-18 12:18:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1143, 1, '2018-05-18 12:19:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1145, 1, '2018-05-18 12:21:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1147, 1, '2018-05-18 12:22:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1149, 1, '2018-05-18 12:23:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1151, 1, '2018-05-18 13:28:36', 'XXXX', '102.136.60.115', '电脑');
INSERT INTO `sys_landing_records` VALUES (1153, 1, '2018-05-18 13:31:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1155, 1, '2018-05-18 13:32:51', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1157, 1, '2018-05-18 13:36:14', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1159, 1, '2018-05-18 13:45:50', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1161, 1, '2018-05-18 13:54:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1163, 1, '2018-05-18 14:37:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1165, 1, '2018-05-18 14:37:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1167, 1, '2018-05-18 14:46:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1169, 1, '2018-05-18 14:53:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1171, 1, '2018-05-18 14:53:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1173, 1, '2018-05-18 15:03:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1175, 1, '2018-05-18 15:04:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1177, 1, '2018-05-18 15:07:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1179, 1, '2018-05-18 15:21:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1181, 1, '2018-05-18 15:36:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1183, 1, '2018-05-18 15:44:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1185, 1, '2018-05-18 15:49:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1187, 1, '2018-05-18 15:51:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1189, 1, '2018-05-18 15:53:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1191, 1, '2018-05-18 15:55:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1193, 1, '2018-05-18 16:01:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1195, 1, '2018-05-18 16:02:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1197, 1, '2018-05-18 16:04:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1199, 1, '2018-05-18 16:05:44', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1201, 1, '2018-05-18 16:06:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1203, 1, '2018-05-18 16:07:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1205, 1, '2018-05-18 16:08:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1207, 1, '2018-05-18 16:13:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1209, 1, '2018-05-18 16:14:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1211, 1, '2018-05-18 16:15:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1213, 1, '2018-05-18 16:37:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1215, 1, '2018-05-18 16:42:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1217, 1, '2018-05-18 16:44:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1219, 1, '2018-05-18 16:49:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1221, 1, '2018-05-18 16:59:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1223, 1, '2018-05-18 17:03:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1225, 1, '2018-05-18 17:10:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1227, 1, '2018-05-18 17:30:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1229, 1, '2018-05-18 17:37:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1231, 1, '2018-05-18 17:41:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1233, 1, '2018-05-18 17:45:08', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1235, 1, '2018-05-18 18:01:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1237, 1, '2018-05-18 18:03:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1239, 1, '2018-05-19 13:26:02', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1241, 1, '2018-05-21 09:04:39', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1243, 1, '2018-05-21 09:12:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1245, 1, '2018-05-21 09:35:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1247, 1, '2018-05-21 09:46:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1249, 1, '2018-05-21 09:53:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1251, 1, '2018-05-21 09:56:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1253, 1, '2018-05-21 10:16:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1255, 1, '2018-05-21 10:27:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1257, 1, '2018-05-21 10:34:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1259, 1, '2018-05-21 10:40:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1261, 1, '2018-05-21 10:40:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1263, 1, '2018-05-21 10:43:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1265, 1, '2018-05-21 10:45:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1267, 1, '2018-05-21 10:46:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1269, 1, '2018-05-21 10:57:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1271, 1, '2018-05-21 10:58:36', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1273, 1, '2018-05-21 11:03:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1275, 1, '2018-05-21 11:06:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1277, 1, '2018-05-21 11:11:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1279, 1, '2018-05-21 11:13:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1281, 1, '2018-05-21 11:15:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1283, 1, '2018-05-21 11:20:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1285, 1, '2018-05-21 11:24:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1287, 1, '2018-05-21 11:28:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1289, 1, '2018-05-21 11:33:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1291, 1, '2018-05-21 11:37:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1293, 1, '2018-05-21 11:37:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1295, 1, '2018-05-21 11:40:12', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1297, 1, '2018-05-21 11:40:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1299, 1, '2018-05-21 11:50:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1301, 1, '2018-05-21 11:52:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1303, 1, '2018-05-21 12:17:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1305, 1, '2018-05-21 13:15:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1307, 1, '2018-05-21 13:16:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1309, 1, '2018-05-21 13:17:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1311, 1, '2018-05-21 13:19:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1313, 1, '2018-05-21 13:20:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1315, 1, '2018-05-21 13:21:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1317, 1, '2018-05-21 13:22:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1319, 1, '2018-05-21 13:29:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1321, 1, '2018-05-21 13:38:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1323, 1, '2018-05-21 13:43:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1325, 1, '2018-05-21 13:53:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1327, 1, '2018-05-21 13:54:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1329, 1, '2018-05-21 13:55:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1331, 1, '2018-05-21 13:58:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1333, 1, '2018-05-21 13:59:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1335, 1, '2018-05-21 14:13:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1337, 1, '2018-05-21 14:16:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1339, 1, '2018-05-21 14:39:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1341, 1, '2018-05-21 15:14:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1343, 1, '2018-05-21 15:21:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1345, 1, '2018-05-21 15:25:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1347, 1, '2018-05-21 15:32:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1349, 1, '2018-05-21 15:37:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1351, 1, '2018-05-21 15:39:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1353, 1, '2018-05-21 15:40:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1355, 1, '2018-05-21 15:54:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1357, 1, '2018-05-21 15:59:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1359, 1, '2018-05-21 16:11:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1361, 1, '2018-05-21 16:31:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1363, 1, '2018-05-21 16:45:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1365, 1, '2018-05-21 16:52:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1367, 1, '2018-05-21 17:23:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1369, 1, '2018-05-21 17:27:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1371, 1, '2018-05-21 17:36:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1373, 1, '2018-05-21 17:38:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1375, 1, '2018-05-21 17:47:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1377, 1, '2018-05-21 17:58:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1379, 1, '2018-05-22 09:11:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1381, 1, '2018-05-22 09:11:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1383, 1, '2018-05-22 09:27:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1385, 1, '2018-05-22 09:32:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1387, 1, '2018-05-22 10:15:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1389, 1, '2018-05-22 10:23:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1391, 1, '2018-05-22 10:34:26', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1393, 1, '2018-05-22 11:28:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1395, 1, '2018-05-22 11:39:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1397, 1, '2018-05-22 11:46:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1399, 1, '2018-05-22 13:18:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1401, 1, '2018-05-22 13:25:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1403, 1, '2018-05-22 13:26:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1405, 1, '2018-05-22 13:31:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1407, 1, '2018-05-22 13:57:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1409, 1, '2018-05-22 13:58:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1411, 1, '2018-05-22 14:00:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1413, 1, '2018-05-22 14:02:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1415, 1, '2018-05-22 14:07:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1417, 1, '2018-05-22 14:09:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1419, 1, '2018-05-22 14:10:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1421, 1, '2018-05-22 14:12:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1423, 1, '2018-05-22 14:13:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1425, 1, '2018-05-22 14:17:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1427, 1, '2018-05-22 14:17:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1429, 1, '2018-05-22 14:19:59', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1431, 1, '2018-05-22 14:20:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1433, 1, '2018-05-22 14:22:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1435, 1, '2018-05-22 14:23:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1437, 1, '2018-05-22 14:25:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1439, 1, '2018-05-22 14:27:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1441, 1, '2018-05-22 14:39:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1443, 1, '2018-05-22 14:41:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1445, 1, '2018-05-22 14:59:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1447, 1, '2018-05-22 15:02:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1449, 1, '2018-05-22 15:04:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1451, 1, '2018-05-22 15:06:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1453, 1, '2018-05-22 15:07:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1455, 1, '2018-05-22 15:12:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1457, 1, '2018-05-22 15:12:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1459, 1, '2018-05-22 15:18:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1461, 1, '2018-05-22 15:21:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1463, 1, '2018-05-22 15:23:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1465, 1, '2018-05-22 15:26:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1467, 1, '2018-05-22 15:27:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1469, 1, '2018-05-22 15:28:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1471, 1, '2018-05-22 15:29:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1473, 1, '2018-05-22 15:30:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1475, 1, '2018-05-22 15:36:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1477, 1, '2018-05-22 15:37:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1479, 1, '2018-05-22 15:42:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1481, 1, '2018-05-22 15:45:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1483, 1, '2018-05-22 15:50:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1485, 1, '2018-05-22 15:53:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1487, 1, '2018-05-22 15:56:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1489, 1, '2018-05-22 16:02:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1491, 1, '2018-05-22 16:13:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1493, 1, '2018-05-22 16:33:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1495, 1, '2018-05-22 17:00:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1497, 1, '2018-05-22 18:04:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1499, 1, '2018-05-23 09:01:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1501, 1, '2018-05-23 09:07:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1503, 1, '2018-05-23 10:56:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1505, 1, '2018-05-23 10:57:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1507, 1, '2018-05-23 11:09:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1509, 1, '2018-05-23 11:17:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1511, 1, '2018-05-23 11:18:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1513, 1, '2018-05-23 11:20:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1515, 1, '2018-05-23 11:25:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1517, 1, '2018-05-23 11:25:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1519, 1, '2018-05-23 13:21:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1521, 1, '2018-05-23 13:29:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1523, 1, '2018-05-23 13:45:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1525, 1, '2018-05-23 13:48:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1527, 1, '2018-05-23 13:48:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1529, 1, '2018-05-23 13:53:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1531, 1, '2018-05-23 14:29:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1533, 1, '2018-05-23 15:01:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1535, 1, '2018-05-23 15:20:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1537, 1, '2018-05-23 15:25:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1539, 1, '2018-05-23 15:43:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1541, 1, '2018-05-23 16:16:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1543, 1, '2018-05-23 16:17:04', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1545, 1, '2018-05-23 16:49:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1547, 1, '2018-05-23 16:51:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1549, 1, '2018-05-23 17:16:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1551, 1, '2018-05-23 17:44:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1553, 1, '2018-05-23 17:59:08', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1555, 1, '2018-05-24 09:03:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1557, 1, '2018-05-24 09:07:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1559, 1, '2018-05-24 09:23:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1561, 1, '2018-05-24 10:20:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1563, 1, '2018-05-24 10:38:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1565, 1, '2018-05-24 13:21:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1567, 1, '2018-05-24 13:25:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1569, 1, '2018-05-24 13:44:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1571, 1, '2018-05-24 13:45:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1573, 1, '2018-05-24 13:54:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1575, 1, '2018-05-24 14:06:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1577, 1, '2018-05-24 14:09:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1579, 1, '2018-05-24 14:27:36', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1581, 1, '2018-05-24 14:38:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1583, 1, '2018-05-24 17:04:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1585, 1, '2018-05-24 17:08:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1587, 1, '2018-05-24 17:32:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1589, 1, '2018-05-24 17:39:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1591, 1, '2018-05-24 17:43:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1593, 1, '2018-05-24 17:53:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1595, 1, '2018-05-24 17:58:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1597, 1, '2018-05-24 18:06:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1599, 1, '2018-05-24 18:11:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1601, 1, '2018-05-24 18:20:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1603, 1, '2018-05-24 18:21:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1605, 1, '2018-05-24 18:22:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1607, 1, '2018-05-24 18:25:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1609, 33, '2018-05-24 18:26:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1611, 33, '2018-05-24 18:26:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1613, 1, '2018-05-25 09:01:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1615, 1, '2018-05-25 09:05:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1617, 1, '2018-05-25 09:06:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1619, 39, '2018-05-25 09:06:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1621, 39, '2018-05-25 09:06:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1623, 1, '2018-05-25 09:08:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1625, 1, '2018-05-25 09:11:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1627, 31, '2018-05-25 09:21:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1629, 31, '2018-05-25 09:21:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1631, 31, '2018-05-25 09:24:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1633, 39, '2018-05-25 09:30:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1635, 31, '2018-05-25 09:37:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1637, 39, '2018-05-25 09:38:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1639, 39, '2018-05-25 09:40:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1641, 1, '2018-05-25 09:44:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1643, 31, '2018-05-25 09:44:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1645, 39, '2018-05-25 09:45:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1647, 39, '2018-05-25 09:47:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1649, 31, '2018-05-25 09:48:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1651, 39, '2018-05-25 09:49:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1653, 1, '2018-05-25 09:53:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1655, 39, '2018-05-25 10:05:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1657, 39, '2018-05-25 10:07:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1659, 1, '2018-05-25 11:15:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1661, 1, '2018-05-25 11:17:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1663, 1, '2018-05-25 11:39:32', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1665, 1, '2018-05-25 11:48:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1667, 1, '2018-05-25 12:13:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1669, 1, '2018-05-25 13:20:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1671, 1, '2018-05-25 13:21:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1673, 1, '2018-05-25 13:22:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1675, 1, '2018-05-25 13:37:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1677, 1, '2018-05-25 13:52:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1679, 1, '2018-05-25 14:22:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1681, 1, '2018-05-25 14:34:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1683, 1, '2018-05-25 14:36:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1685, 1, '2018-05-25 14:37:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1687, 1, '2018-05-25 14:48:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1689, 1, '2018-05-25 14:48:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1691, 1, '2018-05-25 14:51:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1693, 1, '2018-05-25 14:56:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1695, 1, '2018-05-25 14:56:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1697, 1, '2018-05-25 15:00:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1699, 1, '2018-05-25 15:04:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1701, 1, '2018-05-25 15:07:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1703, 1, '2018-05-25 15:11:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1705, 1, '2018-05-25 15:11:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1707, 1, '2018-05-25 15:13:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1709, 1, '2018-05-25 15:18:25', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1711, 1, '2018-05-25 15:19:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1713, 1, '2018-05-25 15:21:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1715, 1, '2018-05-25 15:22:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1717, 1, '2018-05-25 15:28:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1719, 1, '2018-05-25 15:52:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1721, 1, '2018-05-25 15:59:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1723, 1, '2018-05-25 16:02:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1725, 1, '2018-05-25 16:13:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1727, 1, '2018-05-25 16:15:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1729, 1, '2018-05-25 16:20:32', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1731, 1, '2018-05-25 16:31:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1733, 1, '2018-05-25 16:39:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1735, 1, '2018-05-25 16:42:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1737, 1, '2018-05-25 16:42:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1739, 1, '2018-05-25 16:47:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1741, 1, '2018-05-25 16:48:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1743, 1, '2018-05-25 16:50:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1745, 1, '2018-05-25 16:53:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1747, 1, '2018-05-25 16:58:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1749, 1, '2018-05-25 17:03:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1751, 1, '2018-05-25 17:04:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1753, 1, '2018-05-25 17:04:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1755, 1, '2018-05-25 17:05:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1757, 1, '2018-05-25 17:11:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1759, 1, '2018-05-25 17:20:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1761, 1, '2018-05-25 17:30:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1763, 1, '2018-05-25 17:32:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1765, 1, '2018-05-25 17:33:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1767, 1, '2018-05-25 17:43:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1769, 1, '2018-05-25 17:45:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1771, 1, '2018-05-25 17:48:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1773, 1, '2018-05-25 17:52:02', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1775, 1, '2018-05-25 18:00:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1777, 1, '2018-05-25 18:01:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1779, 1, '2018-05-25 18:02:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1781, 1, '2018-05-25 18:04:26', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1783, 1, '2018-05-25 18:09:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1785, 1, '2018-05-25 18:10:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1787, 1, '2018-05-25 18:11:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1789, 1, '2018-05-25 18:15:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1791, 1, '2018-05-25 18:18:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1793, 1, '2018-05-25 18:19:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1795, 1, '2018-05-25 18:22:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1797, 1, '2018-05-25 18:24:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1799, 1, '2018-05-28 09:18:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1801, 1, '2018-05-28 09:25:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1803, 1, '2018-05-28 10:04:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1805, 1, '2018-05-28 10:44:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1807, 1, '2018-05-28 10:49:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1809, 1, '2018-05-28 11:08:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1811, 1, '2018-05-28 13:23:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1813, 1, '2018-05-28 13:28:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1815, 1, '2018-05-28 13:31:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1817, 1, '2018-05-28 13:32:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1819, 1, '2018-05-28 13:48:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1821, 1, '2018-05-28 13:48:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1823, 1, '2018-05-28 14:18:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1825, 1, '2018-05-28 14:40:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1827, 1, '2018-05-28 14:50:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1829, 1, '2018-05-28 14:56:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1831, 1, '2018-05-28 14:59:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1833, 1, '2018-05-28 15:00:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1835, 1, '2018-05-28 15:04:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1837, 1, '2018-05-28 15:05:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1839, 1, '2018-05-28 15:08:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1841, 1, '2018-05-28 15:14:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1843, 1, '2018-05-28 15:17:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1845, 1, '2018-05-28 15:58:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1847, 1, '2018-05-28 16:02:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1849, 1, '2018-05-28 16:09:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1851, 1, '2018-05-28 16:18:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1853, 1, '2018-05-28 16:19:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1855, 1, '2018-05-28 16:38:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1857, 1, '2018-05-28 16:44:54', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1859, 1, '2018-05-28 17:04:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1861, 1, '2018-05-28 17:19:04', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1863, 1, '2018-05-28 17:37:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1865, 1, '2018-05-28 17:40:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1867, 1, '2018-05-28 18:03:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1869, 1, '2018-05-29 09:24:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1871, 1, '2018-05-29 09:24:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1873, 1, '2018-05-29 09:25:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1875, 1, '2018-05-29 10:07:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1877, 1, '2018-05-29 10:38:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1879, 1, '2018-05-29 11:54:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1881, 1, '2018-05-29 13:11:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1883, 1, '2018-05-29 13:20:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1885, 1, '2018-05-29 13:22:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1887, 1, '2018-05-29 13:25:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1889, 1, '2018-05-29 13:47:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1891, 1, '2018-05-29 14:18:08', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1893, 1, '2018-05-29 15:04:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1895, 1, '2018-05-29 15:11:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1897, 1, '2018-05-29 15:13:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (1899, 1, '2018-05-29 16:12:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1901, 1, '2018-05-29 17:11:50', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1903, 1, '2018-05-29 17:38:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1905, 1, '2018-05-29 17:53:54', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1907, 1, '2018-05-29 17:55:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1909, 1, '2018-05-29 17:56:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1911, 1, '2018-05-29 17:59:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1913, 1, '2018-05-29 18:05:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1915, 1, '2018-05-30 09:03:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1917, 1, '2018-05-30 09:17:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1919, 1, '2018-05-30 09:21:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1921, 31, '2018-05-30 09:22:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1923, 1, '2018-05-30 09:28:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1925, 1, '2018-05-30 09:29:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1927, 31, '2018-05-30 09:33:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1929, 1, '2018-05-30 09:39:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1931, 31, '2018-05-30 09:47:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1933, 33, '2018-05-30 09:54:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1935, 37, '2018-05-30 09:56:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1937, 37, '2018-05-30 09:57:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1939, 1, '2018-05-30 10:00:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1941, 1, '2018-05-30 10:07:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1943, 33, '2018-05-30 10:16:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1945, 31, '2018-05-30 10:18:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1947, 1, '2018-05-30 10:20:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1949, 31, '2018-05-30 10:21:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1951, 1, '2018-05-30 10:31:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1953, 1, '2018-05-30 10:31:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1955, 1, '2018-05-30 10:35:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1957, 1, '2018-05-30 10:40:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1959, 1, '2018-05-30 10:45:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1961, 1, '2018-05-30 10:47:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1963, 1, '2018-05-30 10:49:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1965, 1, '2018-05-30 11:05:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1967, 1, '2018-05-30 11:07:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1969, 1, '2018-05-30 11:08:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1971, 1, '2018-05-30 11:11:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1973, 1, '2018-05-30 11:14:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1975, 1, '2018-05-30 11:15:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1977, 1, '2018-05-30 11:19:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1979, 1, '2018-05-30 11:22:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1981, 1, '2018-05-30 11:34:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1983, 1, '2018-05-30 11:39:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1985, 1, '2018-05-30 11:42:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1987, 1, '2018-05-30 11:49:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1989, 1, '2018-05-30 13:14:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (1991, 1, '2018-05-30 13:16:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (1993, 1, '2018-05-30 13:39:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1995, 1, '2018-05-30 14:32:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (1997, 1, '2018-05-30 14:51:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (1999, 1, '2018-05-30 15:25:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2001, 1, '2018-05-30 15:31:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2003, 1, '2018-05-30 15:53:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (2005, 1, '2018-05-30 16:02:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2007, 1, '2018-05-30 16:32:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2009, 1, '2018-05-30 16:36:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2011, 1, '2018-05-30 17:01:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2013, 1, '2018-05-30 17:16:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2015, 1, '2018-05-30 17:23:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2017, 1, '2018-05-30 17:33:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2019, 1, '2018-05-30 17:34:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2021, 31, '2018-05-30 17:46:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2023, 1, '2018-05-30 17:49:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2025, 1, '2018-05-30 17:59:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2027, 1, '2018-05-31 09:01:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2029, 1, '2018-05-31 09:05:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2031, 1, '2018-05-31 09:06:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2033, 1, '2018-05-31 09:09:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2035, 1, '2018-05-31 09:14:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2037, 1, '2018-05-31 09:36:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2039, 1, '2018-05-31 09:40:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2041, 1, '2018-05-31 09:41:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2043, 1, '2018-05-31 09:54:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2045, 1, '2018-05-31 09:55:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2047, 1, '2018-05-31 10:13:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2049, 1, '2018-05-31 10:15:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2051, 1, '2018-05-31 10:16:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2053, 1, '2018-05-31 10:31:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (2055, 1, '2018-05-31 10:37:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2057, 1, '2018-05-31 10:39:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2059, 1, '2018-05-31 10:42:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2061, 1, '2018-05-31 10:43:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2063, 1, '2018-05-31 10:46:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2065, 1, '2018-05-31 10:47:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2067, 1, '2018-05-31 10:54:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2069, 1, '2018-05-31 10:56:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2071, 1, '2018-05-31 10:57:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2073, 1, '2018-05-31 11:08:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2075, 1, '2018-05-31 11:11:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2077, 1, '2018-05-31 11:12:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2079, 1, '2018-05-31 11:22:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2081, 1, '2018-05-31 11:37:57', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2083, 1, '2018-05-31 11:47:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2085, 1, '2018-05-31 13:15:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2087, 1, '2018-05-31 13:24:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2089, 1, '2018-05-31 13:28:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2091, 1, '2018-05-31 13:40:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2093, 1, '2018-05-31 13:57:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2095, 1, '2018-05-31 13:58:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2097, 31, '2018-05-31 13:58:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2099, 31, '2018-05-31 14:01:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2101, 33, '2018-05-31 14:03:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2103, 33, '2018-05-31 14:06:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2105, 33, '2018-05-31 14:07:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2107, 37, '2018-05-31 14:07:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2109, 31, '2018-05-31 14:08:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2111, 33, '2018-05-31 14:10:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2113, 37, '2018-05-31 14:11:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2115, 1, '2018-05-31 14:11:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2117, 31, '2018-05-31 14:12:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2119, 31, '2018-05-31 14:14:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2121, 33, '2018-05-31 14:15:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2123, 33, '2018-05-31 14:16:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2125, 33, '2018-05-31 14:16:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2127, 37, '2018-05-31 14:25:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2129, 31, '2018-05-31 14:36:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2131, 1, '2018-05-31 14:53:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2133, 31, '2018-05-31 14:53:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2135, 1, '2018-05-31 15:22:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2137, 31, '2018-05-31 15:22:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2139, 33, '2018-05-31 15:30:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2141, 37, '2018-05-31 15:31:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2143, 33, '2018-05-31 15:32:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2145, 1, '2018-05-31 15:33:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2147, 39, '2018-05-31 15:34:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2149, 1, '2018-05-31 15:36:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2151, 37, '2018-05-31 15:36:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2153, 39, '2018-05-31 15:38:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2155, 37, '2018-05-31 15:38:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2157, 1, '2018-05-31 15:39:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2159, 31, '2018-05-31 15:40:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2161, 1, '2018-05-31 15:43:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2163, 33, '2018-05-31 15:44:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2165, 37, '2018-05-31 15:44:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2167, 33, '2018-05-31 15:45:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2169, 1, '2018-05-31 15:45:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2171, 39, '2018-05-31 15:46:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2173, 37, '2018-05-31 15:46:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2175, 39, '2018-05-31 15:53:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2177, 1, '2018-05-31 16:08:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2179, 1, '2018-05-31 16:20:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2181, 1, '2018-05-31 16:35:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2183, 1, '2018-05-31 16:37:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2185, 1, '2018-05-31 16:39:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2187, 1, '2018-05-31 16:41:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2189, 1, '2018-05-31 16:49:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2191, 1, '2018-05-31 16:50:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2193, 1, '2018-05-31 16:57:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2195, 1, '2018-05-31 16:58:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2197, 1, '2018-05-31 17:01:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2199, 1, '2018-05-31 17:02:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2201, 33, '2018-05-31 17:06:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2203, 37, '2018-05-31 17:07:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2205, 1, '2018-05-31 17:21:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2207, 1, '2018-05-31 17:23:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2209, 1, '2018-05-31 17:26:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2211, 1, '2018-05-31 17:30:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2213, 1, '2018-05-31 17:31:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2215, 1, '2018-05-31 17:33:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2217, 1, '2018-05-31 17:38:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2219, 1, '2018-05-31 17:41:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2221, 1, '2018-05-31 17:44:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2223, 1, '2018-05-31 18:06:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2225, 1, '2018-06-01 08:58:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2227, 1, '2018-06-01 09:06:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2229, 1, '2018-06-01 09:09:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2231, 1, '2018-06-01 09:15:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2233, 1, '2018-06-01 09:16:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2235, 1, '2018-06-01 09:17:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2237, 1, '2018-06-01 09:17:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2239, 1, '2018-06-01 09:18:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2241, 1, '2018-06-01 09:18:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2243, 1, '2018-06-01 09:19:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2245, 1, '2018-06-01 09:21:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2247, 1, '2018-06-01 09:21:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2249, 1, '2018-06-01 09:41:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2251, 1, '2018-06-01 09:52:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2253, 1, '2018-06-01 10:02:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2255, 1, '2018-06-01 10:03:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2257, 1, '2018-06-01 10:04:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2259, 1, '2018-06-01 10:05:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2261, 1, '2018-06-01 10:05:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2263, 1, '2018-06-01 10:06:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2265, 1, '2018-06-01 10:06:35', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2267, 1, '2018-06-01 10:08:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2269, 1, '2018-06-01 10:12:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2271, 1, '2018-06-01 10:13:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2273, 1, '2018-06-01 10:51:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.64', '电脑');
INSERT INTO `sys_landing_records` VALUES (2275, 1, '2018-06-01 10:53:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2277, 1, '2018-06-01 10:54:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2279, 1, '2018-06-01 10:58:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2281, 1, '2018-06-01 11:03:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2283, 1, '2018-06-01 11:07:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2285, 1, '2018-06-01 11:14:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2287, 1, '2018-06-01 11:21:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2289, 1, '2018-06-01 11:22:19', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2291, 1, '2018-06-01 11:40:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2293, 1, '2018-06-01 13:09:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2295, 1, '2018-06-01 13:17:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2297, 1, '2018-06-01 13:18:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2299, 1, '2018-06-01 13:22:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2301, 1, '2018-06-01 13:44:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2303, 1, '2018-06-01 14:00:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2305, 1, '2018-06-01 14:03:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2307, 1, '2018-06-01 14:40:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2309, 1, '2018-06-01 14:44:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2311, 1, '2018-06-01 14:57:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2313, 1, '2018-06-01 15:02:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2315, 1, '2018-06-01 15:05:22', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2317, 1, '2018-06-01 15:10:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2319, 1, '2018-06-01 15:11:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2321, 1, '2018-06-01 15:56:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2323, 1, '2018-06-01 15:56:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2325, 1, '2018-06-01 15:57:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2327, 1, '2018-06-01 15:59:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2329, 1, '2018-06-01 16:13:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2331, 1, '2018-06-01 16:19:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2333, 1, '2018-06-01 16:27:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2335, 1, '2018-06-01 16:49:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2337, 1, '2018-06-01 16:55:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2339, 33, '2018-06-01 17:00:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2341, 37, '2018-06-01 17:01:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2343, 39, '2018-06-01 17:03:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2345, 37, '2018-06-01 17:04:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2347, 39, '2018-06-01 17:05:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2349, 37, '2018-06-01 17:06:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2351, 33, '2018-06-01 17:07:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2353, 1, '2018-06-01 17:08:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2355, 1, '2018-06-01 17:08:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2357, 1, '2018-06-01 17:09:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2359, 33, '2018-06-01 17:10:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2361, 37, '2018-06-01 17:10:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2363, 1, '2018-06-01 17:19:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2365, 1, '2018-06-01 17:27:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2367, 1, '2018-06-01 17:32:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2369, 1, '2018-06-01 17:38:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2371, 1, '2018-06-01 17:44:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2373, 1, '2018-06-01 17:45:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2375, 1, '2018-06-01 17:53:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2377, 1, '2018-06-01 17:54:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2379, 1, '2018-06-01 17:55:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2381, 1, '2018-06-02 14:49:58', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2383, 1, '2018-06-02 15:53:57', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2385, 1, '2018-06-03 14:32:02', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2387, 1, '2018-06-04 09:34:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2389, 1, '2018-06-04 09:42:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2391, 1, '2018-06-04 09:43:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2393, 1, '2018-06-04 09:46:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2395, 1, '2018-06-04 10:08:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2397, 1, '2018-06-04 10:10:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2399, 1, '2018-06-04 10:11:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2401, 1, '2018-06-04 10:33:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2403, 1, '2018-06-04 10:43:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2405, 1, '2018-06-04 10:46:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2407, 1, '2018-06-04 10:49:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.64', '电脑');
INSERT INTO `sys_landing_records` VALUES (2409, 1, '2018-06-04 11:31:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2411, 1, '2018-06-04 11:34:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2413, 1, '2018-06-04 11:36:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2415, 1, '2018-06-04 11:40:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2417, 1, '2018-06-04 11:53:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2419, 1, '2018-06-04 13:16:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2421, 1, '2018-06-04 13:20:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2423, 1, '2018-06-04 13:22:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2425, 1, '2018-06-04 15:37:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2427, 1, '2018-06-04 15:38:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2429, 1, '2018-06-04 15:39:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2431, 1, '2018-06-04 15:41:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2433, 1, '2018-06-04 15:41:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2435, 1, '2018-06-04 15:42:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2437, 1, '2018-06-04 15:44:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2439, 1, '2018-06-04 15:45:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2441, 1, '2018-06-04 16:04:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2443, 1, '2018-06-04 16:34:21', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2445, 1, '2018-06-04 17:01:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2447, 1, '2018-06-04 17:09:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2449, 1, '2018-06-04 17:20:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2451, 1, '2018-06-04 17:21:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2453, 1, '2018-06-04 17:26:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2455, 1, '2018-06-04 17:27:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2457, 1, '2018-06-05 09:00:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2459, 1, '2018-06-05 09:05:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2461, 1, '2018-06-05 09:07:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2463, 1, '2018-06-05 09:56:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2465, 1, '2018-06-05 10:22:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2467, 1, '2018-06-05 10:34:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2469, 1, '2018-06-05 10:37:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2471, 1, '2018-06-05 10:43:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.64', '电脑');
INSERT INTO `sys_landing_records` VALUES (2473, 1, '2018-06-05 10:52:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2475, 1, '2018-06-05 10:53:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2477, 1, '2018-06-05 10:55:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2479, 1, '2018-06-05 10:57:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2481, 1, '2018-06-05 11:08:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2483, 1, '2018-06-05 11:12:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2485, 1, '2018-06-05 11:14:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2487, 1, '2018-06-05 11:20:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2489, 1, '2018-06-05 11:21:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2491, 1, '2018-06-05 11:23:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2493, 1, '2018-06-05 11:27:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2495, 1, '2018-06-05 11:28:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2497, 1, '2018-06-05 11:36:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2499, 1, '2018-06-05 11:36:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (2501, 1, '2018-06-05 11:46:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2503, 1, '2018-06-05 13:17:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2505, 1, '2018-06-05 13:18:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2507, 1, '2018-06-05 13:20:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2509, 1, '2018-06-05 13:22:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2511, 1, '2018-06-05 13:23:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2513, 1, '2018-06-05 13:31:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2515, 1, '2018-06-05 13:33:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2517, 1, '2018-06-05 13:43:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2519, 1, '2018-06-05 13:46:52', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2521, 1, '2018-06-05 13:57:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2523, 31, '2018-06-05 14:07:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2525, 33, '2018-06-05 14:08:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2527, 1, '2018-06-05 14:12:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2529, 1, '2018-06-05 14:18:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2531, 1, '2018-06-05 14:20:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2533, 1, '2018-06-05 14:27:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2535, 1, '2018-06-05 14:40:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2537, 1, '2018-06-05 14:48:15', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2539, 1, '2018-06-05 15:12:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2541, 1, '2018-06-05 15:23:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2543, 1, '2018-06-05 15:51:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2545, 1, '2018-06-05 15:54:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2547, 1, '2018-06-05 16:05:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2549, 1, '2018-06-05 16:26:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2551, 1, '2018-06-05 16:33:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2553, 1, '2018-06-05 16:33:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2555, 1, '2018-06-05 16:35:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2557, 1, '2018-06-05 16:37:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2559, 1, '2018-06-05 16:38:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2561, 1, '2018-06-05 16:40:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2563, 1, '2018-06-05 16:52:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2565, 1, '2018-06-05 16:55:12', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2567, 1, '2018-06-05 17:01:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2569, 1, '2018-06-05 17:05:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2571, 1, '2018-06-05 17:07:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2573, 1, '2018-06-05 17:21:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2575, 1, '2018-06-05 17:23:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2577, 1, '2018-06-05 17:26:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2579, 1, '2018-06-05 17:28:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2581, 1, '2018-06-05 17:30:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2583, 1, '2018-06-05 17:33:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2585, 1, '2018-06-05 17:36:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2587, 1, '2018-06-05 17:38:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2589, 1, '2018-06-05 17:39:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2591, 1, '2018-06-05 17:39:52', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2593, 1, '2018-06-05 17:46:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2595, 1, '2018-06-05 17:47:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2597, 1, '2018-06-05 17:48:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2599, 1, '2018-06-05 17:50:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2601, 1, '2018-06-05 17:52:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2603, 1, '2018-06-05 17:52:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2605, 1, '2018-06-05 17:54:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2607, 1, '2018-06-05 18:06:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2609, 1, '2018-06-05 18:11:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2611, 1, '2018-06-06 08:59:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2613, 1, '2018-06-06 09:02:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2615, 1, '2018-06-06 09:09:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2617, 1, '2018-06-06 09:17:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2619, 1, '2018-06-06 09:53:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2621, 1, '2018-06-06 09:56:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2623, 1, '2018-06-06 10:01:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2625, 1, '2018-06-06 10:25:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2627, 1, '2018-06-06 10:27:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2629, 1, '2018-06-06 10:32:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2631, 1, '2018-06-06 10:33:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2633, 1, '2018-06-06 10:34:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2635, 1, '2018-06-06 10:36:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2637, 1, '2018-06-06 11:12:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2639, 1, '2018-06-06 11:13:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2641, 1, '2018-06-06 11:24:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2643, 1, '2018-06-06 11:36:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2645, 1, '2018-06-06 11:42:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2647, 1, '2018-06-06 11:44:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2649, 1, '2018-06-06 11:50:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2651, 1, '2018-06-06 13:27:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2653, 1, '2018-06-06 13:46:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2655, 1, '2018-06-06 14:12:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2657, 1, '2018-06-06 14:23:04', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2659, 1, '2018-06-06 14:38:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2661, 1, '2018-06-06 14:50:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2663, 1, '2018-06-06 14:51:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2665, 1, '2018-06-06 15:07:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2667, 1, '2018-06-06 15:21:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2669, 1, '2018-06-06 15:34:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2671, 1, '2018-06-06 15:55:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2673, 1, '2018-06-06 15:57:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2675, 1, '2018-06-06 15:58:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2677, 1, '2018-06-06 15:59:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2679, 1, '2018-06-06 16:02:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2681, 1, '2018-06-06 16:13:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2683, 1, '2018-06-06 16:13:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2685, 1, '2018-06-06 16:14:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2687, 1, '2018-06-06 16:18:04', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2689, 1, '2018-06-06 16:19:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2691, 1, '2018-06-06 16:21:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2693, 1, '2018-06-06 16:43:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2695, 1, '2018-06-06 16:44:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2697, 1, '2018-06-06 16:50:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2699, 1, '2018-06-06 16:51:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2701, 1, '2018-06-06 16:57:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2703, 1, '2018-06-06 16:57:56', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2705, 1, '2018-06-06 17:23:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2707, 1, '2018-06-06 17:47:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2709, 1, '2018-06-07 09:06:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2711, 1, '2018-06-07 09:14:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2713, 1, '2018-06-07 09:23:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2715, 1, '2018-06-07 09:30:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2717, 1, '2018-06-07 09:34:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2719, 1, '2018-06-07 09:45:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2721, 1, '2018-06-07 09:52:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2723, 1, '2018-06-07 09:55:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2725, 1, '2018-06-07 09:58:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2727, 1, '2018-06-07 10:00:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2729, 1, '2018-06-07 10:27:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2731, 1, '2018-06-07 10:38:53', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2733, 1, '2018-06-07 10:39:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2735, 1, '2018-06-07 10:42:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2737, 1, '2018-06-07 10:49:16', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2739, 1, '2018-06-07 10:51:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2741, 1, '2018-06-07 11:11:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2743, 1, '2018-06-07 11:13:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2745, 1, '2018-06-07 11:20:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2747, 1, '2018-06-07 11:23:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2749, 1, '2018-06-07 11:26:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2751, 1, '2018-06-07 11:27:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2753, 1, '2018-06-07 11:28:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2755, 1, '2018-06-07 11:29:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2757, 1, '2018-06-07 11:30:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2759, 1, '2018-06-07 11:48:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2761, 1, '2018-06-07 13:20:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2763, 1, '2018-06-07 13:21:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2765, 1, '2018-06-07 13:24:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2767, 1, '2018-06-07 13:29:54', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2769, 1, '2018-06-07 13:34:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2771, 1, '2018-06-07 13:46:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2773, 1, '2018-06-07 14:11:36', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2775, 1, '2018-06-07 14:17:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2777, 1, '2018-06-07 14:24:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2779, 1, '2018-06-07 14:28:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2781, 1, '2018-06-07 14:31:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2783, 1, '2018-06-07 14:39:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2785, 1, '2018-06-07 14:50:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2787, 1, '2018-06-07 14:57:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2789, 1, '2018-06-07 14:58:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2791, 1, '2018-06-07 15:33:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2793, 1, '2018-06-07 15:43:16', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2795, 1, '2018-06-07 16:03:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2797, 1, '2018-06-07 16:07:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2799, 1, '2018-06-07 16:21:35', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2801, 1, '2018-06-07 16:22:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2803, 1, '2018-06-07 16:33:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2805, 1, '2018-06-07 16:47:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2807, 1, '2018-06-07 16:58:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2809, 1, '2018-06-07 17:19:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2811, 1, '2018-06-08 09:03:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2813, 1, '2018-06-08 09:03:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2815, 1, '2018-06-08 09:13:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2817, 1, '2018-06-08 09:14:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2819, 1, '2018-06-08 10:11:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2821, 1, '2018-06-08 10:45:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2823, 1, '2018-06-08 10:56:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2825, 1, '2018-06-08 11:02:25', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2827, 1, '2018-06-08 11:02:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2829, 1, '2018-06-08 11:05:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2831, 1, '2018-06-08 11:29:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2833, 31, '2018-06-08 11:31:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2835, 1, '2018-06-08 11:31:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2837, 1, '2018-06-08 11:50:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2839, 1, '2018-06-08 11:53:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2841, 1, '2018-06-08 11:53:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2843, 1, '2018-06-08 13:14:59', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2845, 1, '2018-06-08 13:24:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2847, 1, '2018-06-08 13:25:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2849, 1, '2018-06-08 13:27:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2851, 1, '2018-06-08 13:31:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2853, 1, '2018-06-08 13:39:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2855, 1, '2018-06-08 13:46:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2857, 1, '2018-06-08 13:48:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2859, 1, '2018-06-08 13:50:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2861, 1, '2018-06-08 13:58:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2863, 1, '2018-06-08 14:57:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2865, 1, '2018-06-08 15:07:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2867, 1, '2018-06-08 15:15:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2869, 1, '2018-06-08 15:21:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2871, 1, '2018-06-08 15:23:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2873, 1, '2018-06-08 15:30:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2875, 1, '2018-06-08 15:40:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2877, 1, '2018-06-08 15:50:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2879, 1, '2018-06-08 15:51:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2881, 1, '2018-06-08 15:56:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2883, 1, '2018-06-08 15:58:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2885, 1, '2018-06-08 16:12:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2887, 1, '2018-06-08 16:19:01', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2889, 1, '2018-06-08 17:05:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2891, 1, '2018-06-08 17:06:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2893, 1, '2018-06-08 17:10:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.78', '电脑');
INSERT INTO `sys_landing_records` VALUES (2895, 1, '2018-06-09 15:34:19', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2897, 1, '2018-06-09 17:27:30', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2899, 1, '2018-06-11 09:26:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2901, 1, '2018-06-11 09:29:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2903, 1, '2018-06-11 09:39:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2905, 1, '2018-06-11 09:40:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2907, 1, '2018-06-11 09:43:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2909, 1, '2018-06-11 09:50:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (2911, 1, '2018-06-11 09:51:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2913, 1, '2018-06-11 09:59:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2915, 1, '2018-06-11 10:00:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2917, 1, '2018-06-11 10:09:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2919, 1, '2018-06-11 10:12:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2921, 1, '2018-06-11 10:15:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2923, 1, '2018-06-11 10:19:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2925, 1, '2018-06-11 10:20:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2927, 1, '2018-06-11 10:48:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2929, 1, '2018-06-11 10:50:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2931, 1, '2018-06-11 10:52:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2933, 1, '2018-06-11 11:22:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2935, 1, '2018-06-11 11:23:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (2937, 1, '2018-06-11 11:26:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2939, 1, '2018-06-11 11:28:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2941, 1, '2018-06-11 11:29:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2943, 1, '2018-06-11 11:30:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2945, 1, '2018-06-11 11:34:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2947, 1, '2018-06-11 11:35:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2949, 1, '2018-06-11 11:39:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2951, 1, '2018-06-11 11:44:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2953, 39, '2018-06-11 11:46:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2955, 1, '2018-06-11 11:47:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2957, 37, '2018-06-11 11:48:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2959, 39, '2018-06-11 11:49:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2961, 1, '2018-06-11 13:27:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2963, 39, '2018-06-11 13:31:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2965, 33, '2018-06-11 13:33:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2967, 1, '2018-06-11 13:33:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2969, 33, '2018-06-11 13:33:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2971, 37, '2018-06-11 13:35:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2973, 1, '2018-06-11 13:41:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2975, 1, '2018-06-11 13:41:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (2977, 1, '2018-06-11 13:58:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (2979, 1, '2018-06-11 14:17:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (2981, 1, '2018-06-11 14:20:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2983, 1, '2018-06-11 14:33:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2985, 37, '2018-06-11 15:11:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2987, 39, '2018-06-11 15:11:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2989, 39, '2018-06-11 15:17:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2991, 39, '2018-06-11 15:23:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2993, 39, '2018-06-11 15:29:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2995, 39, '2018-06-11 15:32:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2997, 39, '2018-06-11 15:33:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (2999, 37, '2018-06-11 15:33:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3001, 1, '2018-06-11 16:00:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3003, 1, '2018-06-11 16:12:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3005, 37, '2018-06-11 17:40:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3007, 1, '2018-06-11 17:40:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3009, 39, '2018-06-11 17:44:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3011, 1, '2018-06-11 17:49:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3013, 39, '2018-06-11 17:53:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3015, 39, '2018-06-11 17:55:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3017, 39, '2018-06-11 17:57:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3019, 39, '2018-06-11 18:01:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3021, 39, '2018-06-11 18:03:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3023, 39, '2018-06-12 08:56:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3025, 1, '2018-06-12 09:03:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3027, 37, '2018-06-12 09:06:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3029, 1, '2018-06-12 09:07:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3031, 39, '2018-06-12 09:11:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3033, 1, '2018-06-12 09:12:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3035, 37, '2018-06-12 09:14:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3037, 39, '2018-06-12 09:16:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3039, 1, '2018-06-12 09:16:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3041, 31, '2018-06-12 09:18:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3043, 1, '2018-06-12 09:19:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3045, 31, '2018-06-12 09:19:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3047, 39, '2018-06-12 09:23:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3049, 31, '2018-06-12 09:43:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3051, 33, '2018-06-12 09:47:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3053, 1, '2018-06-12 09:48:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3055, 33, '2018-06-12 09:49:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3057, 41, '2018-06-12 09:50:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3059, 41, '2018-06-12 09:51:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3061, 33, '2018-06-12 09:51:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3063, 41, '2018-06-12 09:52:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3065, 43, '2018-06-12 09:53:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3067, 43, '2018-06-12 09:53:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3069, 43, '2018-06-12 09:58:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3071, 1, '2018-06-12 10:31:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3073, 33, '2018-06-12 10:31:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3075, 33, '2018-06-12 10:33:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3077, 1, '2018-06-12 10:36:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3079, 1, '2018-06-12 10:43:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (3081, 31, '2018-06-12 10:46:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3083, 1, '2018-06-12 10:48:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3085, 1, '2018-06-12 10:48:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3087, 33, '2018-06-12 10:48:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3089, 31, '2018-06-12 10:49:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3091, 1, '2018-06-12 10:53:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (3093, 31, '2018-06-12 11:10:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3095, 1, '2018-06-12 11:15:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3097, 1, '2018-06-12 11:19:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3099, 1, '2018-06-12 11:20:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3101, 1, '2018-06-12 11:20:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3103, 1, '2018-06-12 11:21:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3105, 1, '2018-06-12 11:30:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3107, 1, '2018-06-12 11:36:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3109, 1, '2018-06-12 11:46:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3111, 1, '2018-06-12 11:47:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3113, 33, '2018-06-12 11:49:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3115, 31, '2018-06-12 11:50:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3117, 33, '2018-06-12 11:52:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3119, 31, '2018-06-12 11:55:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3121, 31, '2018-06-12 12:07:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3123, 1, '2018-06-12 12:08:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3125, 1, '2018-06-12 12:33:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3127, 1, '2018-06-12 12:59:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3129, 1, '2018-06-12 13:16:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.84', '电脑');
INSERT INTO `sys_landing_records` VALUES (3131, 1, '2018-06-12 13:16:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.84', '电脑');
INSERT INTO `sys_landing_records` VALUES (3133, 1, '2018-06-12 13:20:22', '鍐呯綉IP鍐呯綉IP', '192.168.1.70', '电脑');
INSERT INTO `sys_landing_records` VALUES (3135, 1, '2018-06-12 13:21:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3137, 1, '2018-06-12 13:22:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3139, 1, '2018-06-12 13:32:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3141, 1, '2018-06-12 13:33:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3143, 1, '2018-06-12 13:42:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3145, 1, '2018-06-12 13:42:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3147, 1, '2018-06-12 13:44:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3149, 1, '2018-06-12 13:52:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3151, 1, '2018-06-12 13:53:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3153, 1, '2018-06-12 14:07:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3155, 1, '2018-06-12 14:09:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3157, 1, '2018-06-12 14:16:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3159, 1, '2018-06-12 14:52:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3161, 1, '2018-06-12 15:11:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3163, 1, '2018-06-12 15:24:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3165, 1, '2018-06-12 15:50:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3167, 1, '2018-06-12 15:54:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3169, 1, '2018-06-12 15:59:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3171, 1, '2018-06-12 16:08:36', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3173, 1, '2018-06-12 16:21:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3175, 1, '2018-06-12 16:40:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3177, 1, '2018-06-12 16:42:52', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3179, 1, '2018-06-12 16:45:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3181, 1, '2018-06-12 16:47:04', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3183, 1, '2018-06-12 16:48:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3185, 1, '2018-06-12 16:49:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3187, 1, '2018-06-12 16:49:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3189, 1, '2018-06-12 16:49:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3191, 1, '2018-06-12 16:52:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3193, 1, '2018-06-12 16:56:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3195, 1, '2018-06-12 16:59:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3197, 1, '2018-06-12 16:59:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3199, 1, '2018-06-12 17:02:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3201, 1, '2018-06-12 17:14:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3203, 1, '2018-06-12 17:16:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3205, 1, '2018-06-12 17:18:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3207, 31, '2018-06-12 17:21:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3209, 1, '2018-06-12 17:24:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3211, 1, '2018-06-12 17:27:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3213, 1, '2018-06-12 17:30:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3215, 1, '2018-06-12 17:34:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3217, 1, '2018-06-12 17:41:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3219, 1, '2018-06-12 17:41:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3221, 1, '2018-06-12 17:44:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3223, 1, '2018-06-12 17:45:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3225, 1, '2018-06-12 17:45:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3227, 1, '2018-06-12 17:46:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3229, 1, '2018-06-12 17:46:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3231, 1, '2018-06-12 17:49:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3233, 1, '2018-06-12 17:49:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3235, 1, '2018-06-12 17:51:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3237, 1, '2018-06-12 17:51:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3239, 1, '2018-06-12 17:52:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3241, 1, '2018-06-12 17:54:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3243, 1, '2018-06-13 09:05:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3245, 1, '2018-06-13 09:06:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3247, 1, '2018-06-13 09:23:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3249, 1, '2018-06-13 09:38:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3251, 1, '2018-06-13 09:38:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3253, 1, '2018-06-13 09:45:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3255, 1, '2018-06-13 09:46:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3257, 1, '2018-06-13 10:00:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3259, 1, '2018-06-13 10:02:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3261, 1, '2018-06-13 10:05:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3263, 1, '2018-06-13 10:18:50', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3265, 1, '2018-06-13 10:23:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3267, 1, '2018-06-13 10:27:12', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3269, 1, '2018-06-13 10:28:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3271, 1, '2018-06-13 11:02:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3273, 1, '2018-06-13 11:11:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3275, 1, '2018-06-13 11:18:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3277, 1, '2018-06-13 11:37:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3279, 1, '2018-06-13 11:40:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3281, 1, '2018-06-13 11:46:02', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3283, 1, '2018-06-13 11:46:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3285, 1, '2018-06-13 11:47:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3287, 1, '2018-06-13 11:52:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3289, 33, '2018-06-13 11:57:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3291, 37, '2018-06-13 11:58:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3293, 43, '2018-06-13 11:59:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3295, 37, '2018-06-13 12:00:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3297, 43, '2018-06-13 12:05:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3299, 37, '2018-06-13 12:06:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3301, 37, '2018-06-13 12:09:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3303, 37, '2018-06-13 12:13:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3305, 43, '2018-06-13 12:14:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3307, 37, '2018-06-13 12:14:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3309, 33, '2018-06-13 12:15:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3311, 1, '2018-06-13 12:15:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3313, 33, '2018-06-13 12:15:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3315, 33, '2018-06-13 12:17:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3317, 37, '2018-06-13 12:20:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3319, 33, '2018-06-13 12:22:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3321, 33, '2018-06-13 12:24:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3323, 37, '2018-06-13 12:25:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3325, 33, '2018-06-13 12:26:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3327, 1, '2018-06-13 13:20:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3329, 31, '2018-06-13 13:26:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3331, 1, '2018-06-13 13:28:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3333, 31, '2018-06-13 13:32:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3335, 1, '2018-06-13 13:37:33', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3337, 1, '2018-06-13 13:47:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3339, 1, '2018-06-13 13:52:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3341, 1, '2018-06-13 13:56:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3343, 1, '2018-06-13 14:01:44', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3345, 1, '2018-06-13 14:04:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3347, 1, '2018-06-13 14:11:58', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3349, 1, '2018-06-13 14:14:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3351, 1, '2018-06-13 14:16:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3353, 1, '2018-06-13 14:22:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3355, 1, '2018-06-13 14:27:54', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3357, 1, '2018-06-13 14:30:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3359, 1, '2018-06-13 14:30:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3361, 1, '2018-06-13 14:33:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3363, 1, '2018-06-13 14:35:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3365, 1, '2018-06-13 14:38:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3367, 1, '2018-06-13 14:39:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3369, 31, '2018-06-13 14:42:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3371, 1, '2018-06-13 14:43:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3373, 1, '2018-06-13 15:05:46', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3375, 1, '2018-06-13 15:13:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (3377, 1, '2018-06-13 15:16:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3379, 1, '2018-06-13 15:17:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3381, 1, '2018-06-13 15:23:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3383, 1, '2018-06-13 15:24:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3385, 1, '2018-06-13 15:26:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3387, 1, '2018-06-13 15:27:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3389, 1, '2018-06-13 15:27:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3391, 35, '2018-06-13 15:28:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3393, 1, '2018-06-13 15:28:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3395, 35, '2018-06-13 15:31:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3397, 1, '2018-06-13 15:31:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3399, 1, '2018-06-13 15:33:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3401, 1, '2018-06-13 15:34:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3403, 1, '2018-06-13 15:36:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3405, 35, '2018-06-13 15:37:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3407, 1, '2018-06-13 15:40:17', '未知区域', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3409, 1, '2018-06-13 15:40:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3411, 1, '2018-06-13 15:53:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3413, 1, '2018-06-13 15:55:24', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3415, 1, '2018-06-13 16:06:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3417, 1, '2018-06-13 16:09:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3419, 1, '2018-06-13 16:11:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3421, 1, '2018-06-13 16:15:52', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3423, 1, '2018-06-13 16:22:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3425, 1, '2018-06-13 16:32:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3427, 1, '2018-06-13 16:33:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3429, 1, '2018-06-13 16:47:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3431, 1, '2018-06-13 16:49:50', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3433, 1, '2018-06-13 16:50:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3435, 1, '2018-06-13 17:10:31', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3437, 1, '2018-06-13 17:13:09', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3439, 1, '2018-06-13 17:26:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3441, 1, '2018-06-13 17:31:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3443, 1, '2018-06-13 17:31:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3445, 1, '2018-06-13 17:32:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3447, 1, '2018-06-13 17:34:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3449, 1, '2018-06-13 17:37:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3451, 1, '2018-06-13 17:38:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3453, 33, '2018-06-13 17:39:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3455, 1, '2018-06-13 17:40:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3457, 1, '2018-06-13 17:41:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3459, 1, '2018-06-13 17:42:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3461, 1, '2018-06-13 17:43:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3463, 1, '2018-06-13 17:44:19', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3465, 1, '2018-06-13 17:46:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3467, 1, '2018-06-13 17:51:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3469, 1, '2018-06-14 09:05:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3471, 1, '2018-06-14 09:05:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3473, 1, '2018-06-14 09:14:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3475, 1, '2018-06-14 09:15:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3477, 1, '2018-06-14 09:17:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3479, 1, '2018-06-14 09:21:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3481, 1, '2018-06-14 09:27:39', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3483, 1, '2018-06-14 09:29:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3485, 1, '2018-06-14 09:38:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3487, 1, '2018-06-14 09:56:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3489, 1, '2018-06-14 10:17:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3491, 1, '2018-06-14 10:21:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3493, 1, '2018-06-14 10:31:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3495, 1, '2018-06-14 10:37:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3497, 1, '2018-06-14 10:37:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3499, 1, '2018-06-14 10:42:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3501, 1, '2018-06-14 10:46:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3503, 1, '2018-06-14 10:51:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3505, 1, '2018-06-14 10:53:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3507, 1, '2018-06-14 10:59:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3509, 1, '2018-06-14 11:17:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3511, 1, '2018-06-14 11:29:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3513, 1, '2018-06-14 11:35:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3515, 37, '2018-06-14 11:53:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3517, 41, '2018-06-14 11:53:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3519, 39, '2018-06-14 12:06:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3521, 39, '2018-06-14 12:07:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3523, 39, '2018-06-14 12:16:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3525, 39, '2018-06-14 12:26:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3527, 1, '2018-06-14 13:11:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3529, 1, '2018-06-14 13:13:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3531, 1, '2018-06-14 13:19:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3533, 1, '2018-06-14 13:22:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3535, 1, '2018-06-14 13:24:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3537, 33, '2018-06-14 13:36:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3539, 1, '2018-06-14 13:38:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3541, 1, '2018-06-14 13:38:52', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3543, 33, '2018-06-14 13:38:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3545, 37, '2018-06-14 13:42:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3547, 37, '2018-06-14 13:45:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3549, 1, '2018-06-14 13:48:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3551, 39, '2018-06-14 13:48:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3553, 1, '2018-06-14 13:49:24', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3555, 1, '2018-06-14 13:50:02', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3557, 31, '2018-06-14 13:55:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3559, 1, '2018-06-14 13:56:43', '未知区域', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3561, 39, '2018-06-14 14:03:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3563, 1, '2018-06-14 14:13:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3565, 1, '2018-06-14 14:16:02', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3567, 1, '2018-06-14 14:33:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3569, 1, '2018-06-14 14:34:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3571, 1, '2018-06-14 14:35:44', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3573, 1, '2018-06-14 14:38:26', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3575, 1, '2018-06-14 14:40:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3577, 1, '2018-06-14 14:42:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3579, 1, '2018-06-14 14:43:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3581, 1, '2018-06-14 14:55:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3583, 1, '2018-06-14 14:56:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3585, 1, '2018-06-14 14:58:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3587, 1, '2018-06-14 15:01:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3589, 1, '2018-06-14 15:01:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3591, 1, '2018-06-14 15:02:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3593, 1, '2018-06-14 15:03:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3595, 1, '2018-06-14 15:24:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3597, 1, '2018-06-14 15:25:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3599, 37, '2018-06-14 15:28:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3601, 39, '2018-06-14 15:28:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3603, 1, '2018-06-14 15:30:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3605, 1, '2018-06-14 15:32:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3607, 1, '2018-06-14 15:34:08', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3609, 1, '2018-06-14 15:34:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3611, 1, '2018-06-14 15:34:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3613, 1, '2018-06-14 15:37:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3615, 1, '2018-06-14 15:37:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3617, 1, '2018-06-14 15:37:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3619, 1, '2018-06-14 15:40:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3621, 1, '2018-06-14 15:51:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3623, 1, '2018-06-14 15:53:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3625, 1, '2018-06-14 15:55:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3627, 1, '2018-06-14 16:01:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3629, 1, '2018-06-14 16:01:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3631, 1, '2018-06-14 16:10:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3633, 1, '2018-06-14 16:11:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3635, 1, '2018-06-14 16:11:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3637, 1, '2018-06-14 16:14:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3639, 1, '2018-06-14 16:17:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3641, 1, '2018-06-14 16:20:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3643, 39, '2018-06-14 16:24:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3645, 1, '2018-06-14 16:31:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3647, 1, '2018-06-14 16:31:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3649, 1, '2018-06-14 16:31:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3651, 1, '2018-06-14 16:33:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3653, 1, '2018-06-14 16:36:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3655, 1, '2018-06-14 16:37:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3657, 1, '2018-06-14 16:40:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3659, 1, '2018-06-14 16:41:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3661, 1, '2018-06-14 16:44:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3663, 37, '2018-06-14 16:45:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3665, 1, '2018-06-14 16:50:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3667, 37, '2018-06-14 16:51:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3669, 39, '2018-06-14 16:57:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3671, 39, '2018-06-14 17:00:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3673, 39, '2018-06-14 17:01:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3675, 1, '2018-06-14 17:09:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3677, 1, '2018-06-14 17:17:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3679, 1, '2018-06-14 17:19:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3681, 1, '2018-06-14 17:25:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3683, 1, '2018-06-14 18:00:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3685, 1, '2018-06-14 18:08:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3687, 1, '2018-06-15 08:52:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3689, 1, '2018-06-15 09:02:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3691, 1, '2018-06-15 09:06:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3693, 1, '2018-06-15 09:08:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3695, 1, '2018-06-15 09:12:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3697, 1, '2018-06-15 09:14:11', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3699, 1, '2018-06-15 09:23:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3701, 31, '2018-06-15 09:33:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3703, 31, '2018-06-15 09:35:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3705, 1, '2018-06-15 09:37:34', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3707, 33, '2018-06-15 09:47:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3709, 41, '2018-06-15 09:50:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3711, 41, '2018-06-15 09:52:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3713, 43, '2018-06-15 09:55:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3715, 33, '2018-06-15 10:00:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3717, 33, '2018-06-15 10:05:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3719, 1, '2018-06-15 10:08:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3721, 1, '2018-06-15 10:13:22', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3723, 33, '2018-06-15 10:33:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3725, 33, '2018-06-15 10:34:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3727, 31, '2018-06-15 10:35:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3729, 33, '2018-06-15 10:38:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3731, 31, '2018-06-15 10:46:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3733, 31, '2018-06-15 10:50:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3735, 39, '2018-06-15 10:54:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3737, 37, '2018-06-15 10:55:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3739, 1, '2018-06-15 10:58:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3741, 1, '2018-06-15 11:05:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3743, 1, '2018-06-15 11:14:37', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3745, 1, '2018-06-15 11:18:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3747, 1, '2018-06-15 11:22:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3749, 1, '2018-06-15 11:29:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3751, 1, '2018-06-15 11:32:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3753, 1, '2018-06-15 11:37:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3755, 1, '2018-06-15 11:42:12', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3757, 1, '2018-06-15 13:17:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3759, 1, '2018-06-15 13:23:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3761, 1, '2018-06-15 13:23:53', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3763, 1, '2018-06-15 13:26:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3765, 1, '2018-06-15 13:34:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3767, 1, '2018-06-15 13:35:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3769, 31, '2018-06-15 14:03:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3771, 1, '2018-06-15 14:09:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3773, 31, '2018-06-15 14:10:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3775, 33, '2018-06-15 14:15:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3777, 1, '2018-06-15 14:16:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3779, 1, '2018-06-15 14:21:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3781, 1, '2018-06-15 14:21:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3783, 1, '2018-06-15 14:24:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3785, 1, '2018-06-15 14:32:47', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3787, 31, '2018-06-15 14:33:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3789, 31, '2018-06-15 14:39:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3791, 31, '2018-06-15 14:42:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3793, 31, '2018-06-15 14:50:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3795, 1, '2018-06-15 14:52:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3797, 1, '2018-06-15 15:00:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3799, 1, '2018-06-15 15:07:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3801, 1, '2018-06-15 15:16:04', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3803, 1, '2018-06-15 15:19:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3805, 1, '2018-06-15 15:26:50', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3807, 1, '2018-06-15 15:37:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (3809, 1, '2018-06-15 15:38:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3811, 31, '2018-06-15 15:39:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3813, 1, '2018-06-15 15:39:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3815, 1, '2018-06-15 15:40:59', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3817, 1, '2018-06-15 15:40:59', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3819, 31, '2018-06-15 15:41:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3821, 31, '2018-06-15 15:43:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3823, 1, '2018-06-15 15:49:45', '内网IP内网IP', '192.168.1.65', '电脑');
INSERT INTO `sys_landing_records` VALUES (3825, 31, '2018-06-15 16:01:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3827, 31, '2018-06-15 16:08:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3829, 1, '2018-06-15 16:08:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3831, 31, '2018-06-15 16:15:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3833, 1, '2018-06-15 16:28:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3835, 31, '2018-06-15 16:32:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3837, 31, '2018-06-15 16:35:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3839, 1, '2018-06-15 16:37:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3841, 1, '2018-06-15 16:37:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3843, 31, '2018-06-15 16:38:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3845, 1, '2018-06-15 16:43:06', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3847, 31, '2018-06-15 16:44:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3849, 31, '2018-06-15 16:47:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3851, 31, '2018-06-15 16:48:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3853, 1, '2018-06-15 16:48:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3855, 31, '2018-06-15 16:48:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3857, 31, '2018-06-15 16:56:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3859, 1, '2018-06-15 16:56:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3861, 1, '2018-06-15 16:58:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3863, 1, '2018-06-15 17:00:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3865, 31, '2018-06-15 17:09:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3867, 31, '2018-06-15 17:13:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3869, 1, '2018-06-15 17:48:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3871, 1, '2018-06-19 09:11:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3873, 1, '2018-06-19 09:11:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3875, 1, '2018-06-19 09:13:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3877, 31, '2018-06-19 09:28:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3879, 31, '2018-06-19 09:33:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3881, 1, '2018-06-19 09:45:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3883, 31, '2018-06-19 10:09:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3885, 31, '2018-06-19 10:12:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3887, 1, '2018-06-19 10:15:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3889, 1, '2018-06-19 10:48:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3891, 1, '2018-06-19 11:05:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3893, 31, '2018-06-19 11:39:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3895, 1, '2018-06-19 13:14:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3897, 1, '2018-06-19 13:26:53', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3899, 31, '2018-06-19 13:31:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3901, 33, '2018-06-19 13:35:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3903, 31, '2018-06-19 13:52:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3905, 1, '2018-06-19 14:29:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3907, 1, '2018-06-19 14:35:19', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3909, 33, '2018-06-19 14:49:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3911, 31, '2018-06-19 14:50:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3913, 33, '2018-06-19 14:54:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3915, 31, '2018-06-19 14:56:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3917, 31, '2018-06-19 15:21:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3919, 1, '2018-06-19 15:35:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3921, 31, '2018-06-19 15:44:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3923, 31, '2018-06-19 15:49:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3925, 31, '2018-06-19 15:53:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3927, 31, '2018-06-19 15:55:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3929, 31, '2018-06-19 15:56:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3931, 31, '2018-06-19 16:05:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3933, 31, '2018-06-19 16:09:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3935, 31, '2018-06-19 16:14:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3937, 31, '2018-06-19 16:16:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3939, 31, '2018-06-19 16:18:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3941, 31, '2018-06-19 16:33:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3943, 31, '2018-06-19 16:34:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3945, 31, '2018-06-19 16:38:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3947, 1, '2018-06-19 16:40:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3949, 31, '2018-06-19 16:52:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3951, 1, '2018-06-19 17:10:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3953, 1, '2018-06-19 17:27:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3955, 1, '2018-06-19 17:31:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3957, 31, '2018-06-19 17:36:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3959, 33, '2018-06-19 17:42:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3961, 31, '2018-06-19 17:51:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3963, 1, '2018-06-19 18:23:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3965, 1, '2018-06-19 18:26:30', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3967, 1, '2018-06-20 08:59:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (3969, 1, '2018-06-20 08:59:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3971, 1, '2018-06-20 09:00:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3973, 31, '2018-06-20 09:07:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3975, 33, '2018-06-20 10:01:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3977, 1, '2018-06-20 10:01:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3979, 33, '2018-06-20 10:02:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3981, 1, '2018-06-20 10:08:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3983, 1, '2018-06-20 10:23:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (3985, 1, '2018-06-20 10:49:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3987, 1, '2018-06-20 11:06:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3989, 1, '2018-06-20 11:42:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3991, 1, '2018-06-20 11:43:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3993, 1, '2018-06-20 11:47:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3995, 1, '2018-06-20 12:13:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3997, 1, '2018-06-20 12:19:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (3999, 1, '2018-06-20 12:39:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4001, 1, '2018-06-20 12:40:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4003, 1, '2018-06-20 12:44:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4005, 1, '2018-06-20 13:23:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4007, 1, '2018-06-20 13:23:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4009, 1, '2018-06-20 13:31:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4011, 1, '2018-06-20 13:41:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4013, 1, '2018-06-20 13:54:50', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4015, 1, '2018-06-20 14:11:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4017, 1, '2018-06-20 14:47:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4019, 1, '2018-06-20 14:57:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4021, 1, '2018-06-20 15:01:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4023, 1, '2018-06-20 15:04:08', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4025, 1, '2018-06-20 15:08:25', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4027, 1, '2018-06-20 15:12:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4029, 1, '2018-06-20 15:16:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4031, 1, '2018-06-20 15:17:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4033, 1, '2018-06-20 15:22:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4035, 1, '2018-06-20 15:27:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4037, 1, '2018-06-20 15:32:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4039, 1, '2018-06-20 15:35:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4041, 1, '2018-06-20 15:35:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4043, 31, '2018-06-20 15:41:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4045, 33, '2018-06-20 15:51:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4047, 1, '2018-06-20 16:26:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4049, 1, '2018-06-20 16:33:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4051, 1, '2018-06-20 16:43:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4053, 1, '2018-06-20 16:48:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4055, 1, '2018-06-20 17:23:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4057, 1, '2018-06-20 17:25:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4059, 1, '2018-06-20 17:38:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4061, 1, '2018-06-20 17:40:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4063, 1, '2018-06-20 17:51:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4065, 1, '2018-06-20 18:21:55', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4067, 31, '2018-06-21 09:00:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4069, 1, '2018-06-21 09:02:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4071, 1, '2018-06-21 09:03:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4073, 1, '2018-06-21 09:04:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4075, 33, '2018-06-21 09:06:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4077, 1, '2018-06-21 09:06:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4079, 31, '2018-06-21 09:07:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4081, 1, '2018-06-21 09:16:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4083, 1, '2018-06-21 09:16:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4085, 33, '2018-06-21 09:18:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4087, 1, '2018-06-21 09:18:46', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4089, 31, '2018-06-21 09:28:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4091, 1, '2018-06-21 09:35:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4093, 1, '2018-06-21 09:35:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4095, 31, '2018-06-21 09:44:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4097, 1, '2018-06-21 09:54:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4099, 1, '2018-06-21 09:55:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4101, 1, '2018-06-21 09:59:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4103, 1, '2018-06-21 10:11:01', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4105, 1, '2018-06-21 10:44:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4107, 1, '2018-06-21 10:55:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4109, 1, '2018-06-21 10:55:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4111, 1, '2018-06-21 10:57:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4113, 1, '2018-06-21 10:57:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4115, 41, '2018-06-21 11:07:40', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4117, 1, '2018-06-21 11:08:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4119, 1, '2018-06-21 11:10:54', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4121, 41, '2018-06-21 11:12:09', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4123, 43, '2018-06-21 11:12:43', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4125, 41, '2018-06-21 11:13:46', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4127, 1, '2018-06-21 11:14:12', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4129, 1, '2018-06-21 11:20:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4131, 1, '2018-06-21 11:23:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4133, 1, '2018-06-21 11:29:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (4135, 1, '2018-06-21 11:38:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4137, 1, '2018-06-21 11:39:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4139, 1, '2018-06-21 11:40:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4141, 45, '2018-06-21 11:41:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4143, 45, '2018-06-21 11:41:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4145, 1, '2018-06-21 11:43:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4147, 1, '2018-06-21 11:44:27', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4149, 1, '2018-06-21 11:44:28', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4151, 45, '2018-06-21 11:45:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4153, 1, '2018-06-21 11:46:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4155, 45, '2018-06-21 11:46:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4157, 1, '2018-06-21 11:46:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4159, 45, '2018-06-21 11:51:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4161, 1, '2018-06-21 11:51:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4163, 45, '2018-06-21 11:53:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4165, 1, '2018-06-21 11:53:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4167, 45, '2018-06-21 11:54:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4169, 1, '2018-06-21 11:54:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4171, 1, '2018-06-21 13:21:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4173, 1, '2018-06-21 13:26:20', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4175, 1, '2018-06-21 13:30:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4177, 1, '2018-06-21 13:39:42', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4179, 1, '2018-06-21 13:43:30', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4181, 1, '2018-06-21 13:43:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4183, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4185, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4187, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4189, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4191, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4193, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4195, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4197, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4199, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4201, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4203, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4205, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4207, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4209, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4211, 1, '2018-06-21 13:52:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4213, 1, '2018-06-21 13:52:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4215, 1, '2018-06-21 13:52:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4217, 1, '2018-06-21 13:52:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4219, 1, '2018-06-21 13:53:03', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4221, 1, '2018-06-21 13:57:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4223, 1, '2018-06-21 14:14:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4225, 1, '2018-06-21 15:23:41', '内网IP内网IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4227, 1, '2018-06-21 15:45:46', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4229, 1, '2018-06-21 15:55:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4231, 1, '2018-06-21 16:06:02', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4233, 1, '2018-06-21 17:44:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4235, 1, '2018-06-21 17:58:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4237, 1, '2018-06-21 18:00:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4239, 55, '2018-06-22 09:08:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4241, 1, '2018-06-22 09:17:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4243, 1, '2018-06-22 09:20:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4245, 1, '2018-06-22 10:07:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4247, 1, '2018-06-22 10:28:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4249, 55, '2018-06-22 10:54:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4251, 1, '2018-06-22 11:04:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4253, 1, '2018-06-22 11:29:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4255, 1, '2018-06-22 11:41:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4257, 1, '2018-06-22 11:44:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4259, 1, '2018-06-22 11:49:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4261, 1, '2018-06-22 13:23:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4263, 1, '2018-06-22 13:26:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4265, 1, '2018-06-22 13:26:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4267, 1, '2018-06-22 13:28:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4269, 1, '2018-06-22 13:38:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4271, 1, '2018-06-22 14:58:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4273, 1, '2018-06-22 15:14:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4275, 1, '2018-06-22 15:28:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4277, 1, '2018-06-22 15:34:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4279, 1, '2018-06-22 15:52:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4281, 1, '2018-06-22 15:55:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4283, 1, '2018-06-22 16:31:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4285, 13, '2018-06-22 17:08:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4287, 1, '2018-06-22 17:09:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4289, 1, '2018-06-22 17:11:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4291, 1, '2018-06-25 09:19:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4293, 1, '2018-06-25 09:45:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4295, 23, '2018-06-25 09:58:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4297, 1, '2018-06-25 09:58:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4299, 23, '2018-06-25 09:59:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4301, 1, '2018-06-25 10:05:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4303, 23, '2018-06-25 10:07:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4305, 31, '2018-06-25 10:20:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4307, 55, '2018-06-25 10:22:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4309, 31, '2018-06-25 10:32:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4311, 31, '2018-06-25 10:33:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4313, 37, '2018-06-25 10:34:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4315, 1, '2018-06-25 10:36:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4317, 1, '2018-06-25 10:37:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4319, 23, '2018-06-25 10:37:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4321, 1, '2018-06-25 10:38:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4323, 31, '2018-06-25 10:43:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4325, 1, '2018-06-25 10:47:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4327, 37, '2018-06-25 10:53:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4329, 39, '2018-06-25 10:56:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4331, 1, '2018-06-25 11:31:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4333, 55, '2018-06-25 12:07:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4335, 1, '2018-06-25 12:17:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4337, 1, '2018-06-25 12:22:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4339, 1, '2018-06-25 12:24:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4341, 1, '2018-06-25 13:23:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4343, 1, '2018-06-25 13:29:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4345, 1, '2018-06-25 13:35:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4347, 1, '2018-06-25 13:58:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4349, 1, '2018-06-25 14:02:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4351, 1, '2018-06-25 14:15:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4353, 1, '2018-06-25 15:08:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4355, 55, '2018-06-25 15:56:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4357, 33, '2018-06-25 16:02:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4359, 55, '2018-06-25 16:04:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4361, 1, '2018-06-25 16:05:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4363, 33, '2018-06-25 16:07:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4365, 55, '2018-06-25 16:08:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4367, 1, '2018-06-25 16:15:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4369, 55, '2018-06-25 16:17:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4371, 55, '2018-06-25 16:19:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4373, 55, '2018-06-25 16:22:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4375, 55, '2018-06-25 16:25:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4377, 33, '2018-06-25 16:29:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4379, 55, '2018-06-25 16:30:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4381, 33, '2018-06-25 16:31:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4383, 55, '2018-06-25 16:31:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4385, 33, '2018-06-25 16:32:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4387, 55, '2018-06-25 16:33:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4389, 55, '2018-06-25 16:40:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4391, 55, '2018-06-25 16:40:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4393, 55, '2018-06-25 16:41:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4395, 55, '2018-06-25 16:55:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4397, 33, '2018-06-25 16:55:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4399, 55, '2018-06-25 17:02:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4401, 33, '2018-06-25 17:07:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4403, 55, '2018-06-25 17:07:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4405, 1, '2018-06-25 17:22:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4407, 1, '2018-06-25 17:35:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4409, 1, '2018-06-26 09:01:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4411, 1, '2018-06-26 09:38:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4413, 1, '2018-06-26 09:40:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4415, 1, '2018-06-26 09:51:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4417, 1, '2018-06-26 10:10:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4419, 1, '2018-06-26 10:33:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4421, 55, '2018-06-26 10:37:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4423, 33, '2018-06-26 10:39:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4425, 33, '2018-06-26 10:41:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4427, 1, '2018-06-26 10:44:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4429, 1, '2018-06-26 11:08:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4431, 1, '2018-06-26 11:11:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4433, 1, '2018-06-26 11:18:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4435, 1, '2018-06-26 11:18:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4437, 1, '2018-06-26 11:33:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4439, 1, '2018-06-26 13:27:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4441, 1, '2018-06-26 13:32:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4443, 1, '2018-06-26 13:36:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4445, 33, '2018-06-26 13:48:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4447, 37, '2018-06-26 13:49:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4449, 39, '2018-06-26 13:53:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4451, 37, '2018-06-26 13:54:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4453, 39, '2018-06-26 13:54:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4455, 1, '2018-06-26 13:57:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4457, 39, '2018-06-26 14:00:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4459, 1, '2018-06-26 14:01:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4461, 33, '2018-06-26 14:01:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4463, 1, '2018-06-26 14:23:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4465, 1, '2018-06-26 14:48:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4467, 1, '2018-06-26 14:49:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4469, 1, '2018-06-26 15:23:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4471, 13, '2018-06-26 15:27:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4473, 1, '2018-06-26 15:30:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4475, 33, '2018-06-26 15:33:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4477, 37, '2018-06-26 15:36:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4479, 1, '2018-06-26 15:43:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4481, 1, '2018-06-26 15:45:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4483, 55, '2018-06-26 15:51:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4485, 37, '2018-06-26 16:00:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4487, 39, '2018-06-26 16:01:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4489, 55, '2018-06-26 16:04:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4491, 55, '2018-06-26 16:16:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4493, 39, '2018-06-26 16:17:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4495, 1, '2018-06-26 17:31:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4497, 37, '2018-06-26 17:38:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4499, 37, '2018-06-26 17:59:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4501, 1, '2018-06-27 09:01:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4503, 1, '2018-06-27 09:15:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4505, 37, '2018-06-27 09:16:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4507, 39, '2018-06-27 09:24:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4509, 37, '2018-06-27 09:24:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4511, 37, '2018-06-27 09:34:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4513, 37, '2018-06-27 09:52:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4515, 1, '2018-06-27 10:05:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4517, 1, '2018-06-27 10:08:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4519, 1, '2018-06-27 10:14:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4521, 1, '2018-06-27 10:27:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4523, 55, '2018-06-27 11:05:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4525, 1, '2018-06-27 11:06:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4527, 33, '2018-06-27 11:06:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4529, 1, '2018-06-27 11:11:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4531, 1, '2018-06-27 11:36:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4533, 1, '2018-06-27 13:19:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4535, 1, '2018-06-27 14:07:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4537, 1, '2018-06-27 14:14:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4539, 1, '2018-06-27 14:14:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4541, 1, '2018-06-27 14:27:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4543, 1, '2018-06-27 14:37:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4545, 1, '2018-06-27 14:47:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4547, 1, '2018-06-27 14:56:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4549, 1, '2018-06-27 15:06:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4551, 1, '2018-06-27 15:09:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4553, 1, '2018-06-27 15:25:46', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4555, 1, '2018-06-27 15:33:28', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4557, 1, '2018-06-27 15:37:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4559, 1, '2018-06-27 15:49:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4561, 1, '2018-06-27 15:50:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4563, 1, '2018-06-27 16:13:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4565, 1, '2018-06-27 16:16:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4567, 1, '2018-06-27 16:18:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4569, 1, '2018-06-27 16:23:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4571, 1, '2018-06-28 09:53:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4573, 1, '2018-06-28 11:08:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.61', '电脑');
INSERT INTO `sys_landing_records` VALUES (4575, 1, '2018-06-28 11:28:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4577, 1, '2018-06-28 11:39:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4579, 1, '2018-06-28 13:42:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4581, 1, '2018-06-28 14:36:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4583, 1, '2018-06-28 15:39:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4585, 1, '2018-06-28 17:24:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4587, 1, '2018-06-29 09:09:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4589, 1, '2018-06-29 09:31:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4591, 1, '2018-06-29 13:24:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4593, 1, '2018-07-02 09:47:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4595, 1, '2018-07-02 13:07:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4597, 1, '2018-07-02 13:19:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4599, 1, '2018-07-02 16:41:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4601, 31, '2018-07-02 17:22:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4603, 1, '2018-07-02 17:22:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4605, 31, '2018-07-02 17:23:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4607, 1, '2018-07-02 17:24:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4609, 1, '2018-07-03 09:14:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4611, 1, '2018-07-03 10:27:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4613, 1, '2018-07-03 11:09:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4615, 1, '2018-07-03 13:21:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4617, 1, '2018-07-03 13:54:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4619, 1, '2018-07-03 15:52:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4621, 1, '2018-07-03 16:21:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4623, 1, '2018-07-03 16:22:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4625, 1, '2018-07-04 09:35:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4627, 1, '2018-07-04 10:05:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4629, 1, '2018-07-04 14:41:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4631, 1, '2018-07-04 14:45:29', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4633, 1, '2018-07-04 15:36:11', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4635, 1, '2018-07-04 15:47:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4637, 1, '2018-07-04 15:56:23', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4639, 1, '2018-07-05 09:06:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4641, 1, '2018-07-05 09:13:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4643, 1, '2018-07-05 10:04:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4645, 1, '2018-07-05 13:41:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4647, 1, '2018-07-06 09:05:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4649, 1, '2018-07-06 09:07:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4651, 1, '2018-07-06 09:28:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4653, 1, '2018-07-06 13:08:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4655, 1, '2018-07-06 16:17:25', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4657, 1, '2018-07-06 16:25:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4659, 1, '2018-07-06 16:30:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4661, 1, '2018-07-06 16:37:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4663, 1, '2018-07-06 16:44:44', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4665, 1, '2018-07-06 16:48:43', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4667, 1, '2018-07-06 16:49:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4669, 1, '2018-07-06 16:52:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4671, 1, '2018-07-06 16:56:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4673, 1, '2018-07-06 17:00:22', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4675, 1, '2018-07-06 17:28:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4677, 1, '2018-07-06 17:28:30', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4679, 1, '2018-07-06 17:44:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4681, 1, '2018-07-09 09:20:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4683, 1, '2018-07-09 10:26:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4685, 1, '2018-07-09 11:04:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4687, 1, '2018-07-09 11:47:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4689, 1, '2018-07-09 13:18:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4691, 1, '2018-07-09 14:04:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4693, 1, '2018-07-09 14:52:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4695, 1, '2018-07-09 14:56:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4697, 1, '2018-07-09 15:09:36', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4699, 1, '2018-07-09 16:16:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4701, 1, '2018-07-09 17:26:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4703, 1, '2018-07-10 09:17:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4705, 1, '2018-07-10 09:17:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4707, 1, '2018-07-10 09:56:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4709, 1, '2018-07-10 10:07:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (4711, 1, '2018-07-10 11:39:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4713, 31, '2018-07-10 11:44:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4715, 1, '2018-07-10 11:45:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4717, 55, '2018-07-10 11:50:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4719, 55, '2018-07-10 11:50:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4721, 55, '2018-07-10 13:29:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4723, 55, '2018-07-10 13:29:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4725, 1, '2018-07-10 13:42:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4727, 1, '2018-07-10 14:34:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4729, 1, '2018-07-10 14:53:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (4731, 1, '2018-07-11 09:47:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4733, 1, '2018-07-11 09:48:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4735, 1, '2018-07-11 09:52:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4737, 1, '2018-07-11 09:58:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4739, 1, '2018-07-11 13:51:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4741, 1, '2018-07-11 13:53:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4743, 1, '2018-07-11 14:05:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4745, 1, '2018-07-11 15:01:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4747, 1, '2018-07-11 15:09:21', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4749, 1, '2018-07-11 15:17:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4751, 1, '2018-07-11 15:29:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4753, 1, '2018-07-11 15:29:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4755, 1, '2018-07-11 15:34:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4757, 1, '2018-07-11 15:40:14', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4759, 1, '2018-07-12 11:16:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4761, 1, '2018-07-12 14:00:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4763, 1, '2018-07-12 14:03:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4765, 1, '2018-07-12 14:03:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4767, 1, '2018-07-12 14:05:08', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4769, 1, '2018-07-12 14:05:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4771, 1, '2018-07-12 14:06:32', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4773, 1, '2018-07-12 14:12:15', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4775, 1, '2018-07-12 14:18:13', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4777, 1, '2018-07-12 16:49:39', '内网IP', '192.168.1.65', '电脑');
INSERT INTO `sys_landing_records` VALUES (4779, 1, '2018-07-12 16:58:20', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4781, 1, '2018-07-12 17:03:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4783, 1, '2018-07-12 17:04:39', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4785, 1, '2018-07-12 17:59:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4787, 1, '2018-07-13 10:33:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4789, 1, '2018-07-13 11:12:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4791, 1, '2018-07-13 13:26:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4793, 1, '2018-07-13 13:59:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4795, 1, '2018-07-13 14:05:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4797, 1, '2018-07-13 14:54:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4799, 1, '2018-07-13 16:09:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4801, 1, '2018-07-13 16:10:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4803, 1, '2018-07-13 16:11:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4805, 1, '2018-07-13 16:12:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4807, 1, '2018-07-13 16:13:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4809, 1, '2018-07-13 16:16:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4811, 1, '2018-07-13 16:20:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4813, 1, '2018-07-13 16:21:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4815, 1, '2018-07-13 16:23:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4817, 35, '2018-07-13 17:40:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4819, 1, '2018-07-13 17:40:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4821, 35, '2018-07-13 17:41:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4823, 1, '2018-07-13 17:42:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4825, 1, '2018-07-16 09:08:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4827, 1, '2018-07-16 09:48:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4829, 1, '2018-07-16 10:08:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4831, 1, '2018-07-16 13:18:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4833, 1, '2018-07-16 13:18:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4835, 1, '2018-07-16 13:20:14', '内网IP内网IP', '192.168.1.66', '电脑');
INSERT INTO `sys_landing_records` VALUES (4837, 1, '2018-07-16 13:43:58', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4839, 1, '2018-07-16 13:46:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4841, 1, '2018-07-16 13:48:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4843, 1, '2018-07-16 14:35:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4845, 1, '2018-07-16 15:52:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4847, 1, '2018-07-17 09:19:44', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4849, 1, '2018-07-17 10:00:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4851, 1, '2018-07-17 10:19:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4853, 1, '2018-07-17 10:22:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4855, 1, '2018-07-17 10:23:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (4857, 1, '2018-07-17 10:32:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4859, 1, '2018-07-17 10:34:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4861, 1, '2018-07-17 10:47:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4863, 1, '2018-07-17 10:52:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4865, 1, '2018-07-17 11:09:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4867, 1, '2018-07-17 11:45:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4869, 1, '2018-07-17 13:25:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4871, 1, '2018-07-17 13:30:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4873, 1, '2018-07-17 13:31:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4875, 1, '2018-07-17 13:36:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4877, 1, '2018-07-17 13:43:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4879, 1, '2018-07-17 14:08:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4881, 1, '2018-07-17 14:17:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4883, 1, '2018-07-18 09:19:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4885, 1, '2018-07-18 10:14:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4887, 1, '2018-07-18 10:51:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4889, 1, '2018-07-18 11:49:13', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4891, 1, '2018-07-18 13:26:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4893, 1, '2018-07-18 13:52:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4895, 1, '2018-07-18 15:02:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4897, 31, '2018-07-18 15:16:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4899, 33, '2018-07-18 15:16:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4901, 31, '2018-07-18 15:17:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4903, 31, '2018-07-18 15:31:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4905, 1, '2018-07-18 15:34:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4907, 31, '2018-07-18 15:36:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4909, 1, '2018-07-18 15:39:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4911, 31, '2018-07-18 15:53:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4913, 31, '2018-07-18 15:55:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4915, 31, '2018-07-18 15:59:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4917, 31, '2018-07-18 16:00:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4919, 31, '2018-07-18 16:03:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4921, 31, '2018-07-18 16:12:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4923, 1, '2018-07-18 17:18:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4925, 1, '2018-07-18 17:18:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4927, 1, '2018-07-18 17:23:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4929, 1, '2018-07-18 17:24:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4931, 1, '2018-07-18 17:25:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4933, 1, '2018-07-19 09:06:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4935, 1, '2018-07-19 14:12:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4937, 1, '2018-07-19 17:05:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4939, 1, '2018-07-19 17:40:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4941, 1, '2018-07-20 10:07:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4943, 31, '2018-07-20 10:12:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4945, 1, '2018-07-20 10:19:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4947, 1, '2018-07-20 10:20:54', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4949, 1, '2018-07-20 10:22:26', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4951, 1, '2018-07-20 10:49:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4953, 1, '2018-07-20 11:03:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4955, 1, '2018-07-20 11:10:02', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4957, 1, '2018-07-20 11:29:12', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4959, 1, '2018-07-20 11:43:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4961, 1, '2018-07-20 11:49:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4963, 1, '2018-07-20 11:54:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4965, 1, '2018-07-20 13:25:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4967, 1, '2018-07-20 13:44:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4969, 1, '2018-07-20 13:57:48', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4971, 1, '2018-07-20 13:59:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4973, 1, '2018-07-20 14:59:14', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4975, 1, '2018-07-20 15:11:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4977, 31, '2018-07-20 15:29:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4979, 33, '2018-07-20 15:32:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4981, 35, '2018-07-20 15:32:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4983, 31, '2018-07-20 15:37:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4985, 35, '2018-07-20 15:38:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4987, 1, '2018-07-20 15:49:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4989, 1, '2018-07-23 09:52:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4991, 1, '2018-07-23 10:07:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4993, 1, '2018-07-23 10:12:41', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4995, 1, '2018-07-23 10:17:56', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (4997, 1, '2018-07-23 10:41:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (4999, 1, '2018-07-23 10:51:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5001, 1, '2018-07-23 10:58:34', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5003, 1, '2018-07-23 11:03:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5005, 1, '2018-07-23 11:20:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5007, 1, '2018-07-23 11:22:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5009, 1, '2018-07-23 11:22:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5011, 1, '2018-07-23 11:26:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5013, 1, '2018-07-23 11:42:48', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5015, 1, '2018-07-23 11:53:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5017, 1, '2018-07-23 13:21:23', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5019, 1, '2018-07-23 13:22:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5021, 1, '2018-07-23 13:55:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5023, 1, '2018-07-23 13:59:27', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5025, 1, '2018-07-23 14:03:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5027, 1, '2018-07-23 14:10:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5029, 1, '2018-07-23 14:17:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5031, 31, '2018-07-23 14:17:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5033, 33, '2018-07-23 14:17:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5035, 1, '2018-07-23 14:33:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5037, 33, '2018-07-23 14:41:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5039, 33, '2018-07-23 14:44:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5041, 1, '2018-07-23 14:45:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5043, 33, '2018-07-23 14:45:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5045, 33, '2018-07-23 14:47:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5047, 33, '2018-07-23 14:52:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5049, 1, '2018-07-23 14:54:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5051, 33, '2018-07-23 14:56:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5053, 1, '2018-07-23 16:20:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (5055, 1, '2018-07-23 17:39:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5057, 33, '2018-07-23 17:47:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5059, 33, '2018-07-23 17:50:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5061, 33, '2018-07-23 17:51:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5063, 1, '2018-07-24 09:08:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5065, 1, '2018-07-24 10:08:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5067, 1, '2018-07-24 11:24:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5069, 33, '2018-07-24 11:51:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5071, 33, '2018-07-24 13:19:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5073, 35, '2018-07-24 13:28:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5075, 31, '2018-07-24 13:35:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5077, 35, '2018-07-24 13:37:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5079, 1, '2018-07-24 13:44:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5081, 1, '2018-07-24 14:00:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5083, 1, '2018-07-24 14:46:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5085, 35, '2018-07-24 14:47:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5087, 1, '2018-07-24 14:59:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5089, 31, '2018-07-24 15:35:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5091, 1, '2018-07-24 15:46:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5093, 1, '2018-07-24 15:48:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5095, 1, '2018-07-24 15:49:03', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5097, 1, '2018-07-24 15:50:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5099, 1, '2018-07-24 15:54:22', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5101, 1, '2018-07-24 15:59:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5103, 31, '2018-07-24 16:00:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5105, 1, '2018-07-24 16:13:59', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5107, 1, '2018-07-24 16:15:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5109, 35, '2018-07-24 16:16:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5111, 1, '2018-07-24 16:17:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5113, 1, '2018-07-24 16:32:16', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5115, 1, '2018-07-24 16:33:07', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5117, 1, '2018-07-24 17:20:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5119, 1, '2018-07-24 17:28:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5121, 1, '2018-07-24 17:30:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5123, 1, '2018-07-24 18:02:09', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5125, 1, '2018-07-24 18:03:42', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5127, 1, '2018-07-25 09:09:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5129, 1, '2018-07-25 09:24:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5131, 1, '2018-07-25 10:00:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5133, 1, '2018-07-25 13:22:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5135, 1, '2018-07-25 14:31:38', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5137, 1, '2018-07-25 14:31:45', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5139, 31, '2018-07-25 15:04:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5141, 33, '2018-07-25 15:08:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5143, 1, '2018-07-25 16:06:02', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5145, 1, '2018-07-25 16:12:55', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5147, 1, '2018-07-25 16:20:00', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5149, 1, '2018-07-25 16:23:33', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5151, 1, '2018-07-25 16:32:24', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5153, 1, '2018-07-26 09:24:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5155, 1, '2018-07-26 10:47:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5157, 1, '2018-07-26 14:12:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5159, 1, '2018-07-26 14:26:36', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5161, 1, '2018-07-26 14:46:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5163, 1, '2018-07-26 15:44:31', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5165, 1, '2018-07-26 16:01:27', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5167, 1, '2018-07-26 18:01:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5169, 1, '2018-07-27 09:23:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5171, 1, '2018-07-27 09:44:01', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5173, 1, '2018-07-27 10:12:53', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5175, 1, '2018-07-27 13:24:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5177, 33, '2018-07-27 16:10:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5179, 31, '2018-07-27 16:10:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5181, 1, '2018-07-30 10:47:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5183, 1, '2018-07-30 10:52:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5185, 33, '2018-07-30 10:52:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5187, 31, '2018-07-30 11:28:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5189, 33, '2018-07-30 11:29:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5191, 31, '2018-07-30 11:29:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5193, 35, '2018-07-30 11:31:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5195, 31, '2018-07-30 11:38:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5197, 35, '2018-07-30 11:43:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5199, 35, '2018-07-30 11:45:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5201, 31, '2018-07-30 11:49:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5203, 31, '2018-07-30 12:28:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5205, 33, '2018-07-30 13:25:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5207, 1, '2018-07-30 13:37:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5209, 1, '2018-07-30 13:54:09', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5211, 1, '2018-07-30 13:59:35', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5213, 1, '2018-07-30 14:00:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5215, 1, '2018-07-30 14:08:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5217, 1, '2018-07-30 14:09:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5219, 1, '2018-07-30 14:36:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5221, 1, '2018-07-30 15:01:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5223, 1, '2018-07-30 15:06:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5225, 13, '2018-07-30 15:06:29', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5227, 1, '2018-07-30 15:30:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5229, 33, '2018-07-30 15:36:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5231, 1, '2018-07-30 15:55:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5233, 33, '2018-07-30 17:20:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5235, 35, '2018-07-30 17:20:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5237, 35, '2018-07-30 17:31:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5239, 33, '2018-07-30 17:47:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5241, 1, '2018-07-30 18:04:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5243, 1, '2018-07-31 09:13:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5245, 1, '2018-07-31 09:15:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5247, 1, '2018-07-31 09:23:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5249, 33, '2018-07-31 10:43:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5251, 1, '2018-07-31 11:09:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5253, 1, '2018-07-31 11:31:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.88', '电脑');
INSERT INTO `sys_landing_records` VALUES (5255, 31, '2018-07-31 11:42:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5257, 31, '2018-07-31 13:19:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5259, 33, '2018-07-31 13:19:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5261, 1, '2018-07-31 13:58:01', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5263, 31, '2018-07-31 14:35:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5265, 13, '2018-07-31 14:38:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5267, 33, '2018-07-31 14:41:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5269, 31, '2018-07-31 14:43:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5271, 35, '2018-07-31 14:43:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5273, 31, '2018-07-31 14:51:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5275, 35, '2018-07-31 14:51:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5277, 33, '2018-07-31 14:52:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5279, 1, '2018-07-31 14:53:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5281, 31, '2018-07-31 14:58:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5283, 33, '2018-07-31 15:12:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5285, 31, '2018-07-31 15:13:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5287, 31, '2018-07-31 16:12:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5289, 33, '2018-07-31 16:21:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5291, 33, '2018-07-31 16:42:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5293, 33, '2018-07-31 16:43:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5295, 33, '2018-07-31 17:26:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5297, 31, '2018-07-31 17:34:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5299, 35, '2018-07-31 17:34:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5301, 33, '2018-07-31 17:34:54', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5303, 1, '2018-07-31 17:40:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5305, 35, '2018-07-31 17:51:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5307, 35, '2018-07-31 17:52:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5309, 1, '2018-08-01 09:06:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5311, 1, '2018-08-01 09:33:10', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5313, 35, '2018-08-01 10:31:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5315, 1, '2018-08-01 10:55:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5317, 35, '2018-08-01 10:59:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5319, 1, '2018-08-01 11:21:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5321, 1, '2018-08-01 13:17:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5323, 1, '2018-08-01 13:42:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5325, 33, '2018-08-01 13:52:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5327, 31, '2018-08-01 14:00:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5329, 33, '2018-08-01 14:00:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5331, 1, '2018-08-01 14:06:47', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5333, 33, '2018-08-01 14:07:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5335, 1, '2018-08-01 16:37:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5337, 31, '2018-08-01 16:55:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5339, 31, '2018-08-01 16:57:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5341, 1, '2018-08-01 17:00:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5343, 31, '2018-08-01 17:02:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5345, 1, '2018-08-01 17:45:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5347, 31, '2018-08-01 17:45:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5349, 1, '2018-08-02 09:08:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5351, 1, '2018-08-02 09:11:31', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5353, 1, '2018-08-02 11:35:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5355, 1, '2018-08-02 14:53:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5357, 1, '2018-08-02 15:28:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5359, 1, '2018-08-02 16:10:05', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5361, 1, '2018-08-02 16:17:10', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5363, 1, '2018-08-02 16:21:19', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5365, 1, '2018-08-02 17:06:17', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5367, 1, '2018-08-02 17:06:51', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5369, 1, '2018-08-02 17:19:58', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5371, 1, '2018-08-02 17:54:40', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5373, 1, '2018-08-06 10:35:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5375, 31, '2018-08-06 13:27:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5377, 1, '2018-08-06 14:31:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5379, 31, '2018-08-06 15:42:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5381, 35, '2018-08-06 15:43:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5383, 31, '2018-08-06 16:40:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5385, 1, '2018-08-06 16:57:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5387, 55, '2018-08-06 17:11:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5389, 31, '2018-08-06 17:28:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5391, 1, '2018-08-06 17:35:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5393, 1, '2018-08-07 09:05:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5395, 1, '2018-08-07 10:08:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5397, 31, '2018-08-07 10:33:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5399, 33, '2018-08-07 11:04:06', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5401, 31, '2018-08-07 11:04:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5403, 33, '2018-08-07 11:14:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5405, 31, '2018-08-07 11:15:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5407, 1, '2018-08-07 11:18:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5409, 31, '2018-08-07 11:27:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5411, 33, '2018-08-07 11:27:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5413, 31, '2018-08-07 11:29:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5415, 1, '2018-08-07 11:37:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5417, 1, '2018-08-07 13:13:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5419, 1, '2018-08-07 13:14:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5421, 31, '2018-08-07 15:00:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5423, 1, '2018-08-07 15:28:08', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5425, 31, '2018-08-07 16:14:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5427, 33, '2018-08-07 16:14:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5429, 31, '2018-08-07 16:15:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5431, 33, '2018-08-07 16:19:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5433, 1, '2018-08-08 09:11:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5435, 33, '2018-08-08 10:15:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5437, 1, '2018-08-08 11:17:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5439, 35, '2018-08-08 11:19:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5441, 1, '2018-08-08 13:32:12', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5443, 33, '2018-08-08 15:14:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5445, 1, '2018-08-08 15:14:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5447, 1, '2018-08-08 15:19:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5449, 33, '2018-08-08 15:27:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5451, 33, '2018-08-08 15:47:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5453, 35, '2018-08-08 16:22:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5455, 33, '2018-08-08 16:24:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5457, 31, '2018-08-08 16:24:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5459, 33, '2018-08-08 16:26:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5461, 31, '2018-08-08 16:34:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5463, 33, '2018-08-08 16:37:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5465, 31, '2018-08-08 16:38:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5467, 33, '2018-08-08 16:39:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5469, 35, '2018-08-09 09:02:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5471, 1, '2018-08-09 09:08:51', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5473, 1, '2018-08-09 09:14:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5475, 43, '2018-08-09 09:47:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5477, 39, '2018-08-09 09:47:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5479, 1, '2018-08-09 09:48:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5481, 33, '2018-08-09 09:52:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5483, 1, '2018-08-09 12:20:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5485, 33, '2018-08-09 13:33:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5487, 1, '2018-08-09 13:53:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5489, 35, '2018-08-09 13:53:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5491, 1, '2018-08-09 13:54:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5493, 33, '2018-08-09 13:58:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5495, 31, '2018-08-09 13:59:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5497, 33, '2018-08-09 13:59:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5499, 1, '2018-08-09 14:00:31', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5501, 33, '2018-08-09 14:00:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5503, 1, '2018-08-09 14:04:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5505, 31, '2018-08-09 14:30:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5507, 33, '2018-08-09 14:39:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5509, 31, '2018-08-09 14:43:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5511, 31, '2018-08-09 15:18:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5513, 1, '2018-08-09 15:22:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5515, 31, '2018-08-09 15:24:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5517, 31, '2018-08-09 15:25:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5519, 1, '2018-08-10 10:04:37', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5521, 33, '2018-08-10 15:17:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5523, 31, '2018-08-10 15:33:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5525, 31, '2018-08-10 15:41:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5527, 1, '2018-08-10 15:52:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5529, 35, '2018-08-10 17:52:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5531, 1, '2018-08-10 18:03:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5533, 1, '2018-08-13 09:23:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5535, 1, '2018-08-13 09:36:11', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5537, 35, '2018-08-13 10:35:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5539, 31, '2018-08-13 10:42:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5541, 33, '2018-08-13 10:43:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5543, 35, '2018-08-13 10:44:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5545, 31, '2018-08-13 10:58:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5547, 33, '2018-08-13 10:59:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5549, 35, '2018-08-13 10:59:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5551, 1, '2018-08-13 11:44:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5553, 1, '2018-08-13 13:19:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5555, 1, '2018-08-13 13:21:43', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5557, 1, '2018-08-13 14:24:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5559, 1, '2018-08-13 15:35:38', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5561, 33, '2018-08-13 16:59:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5563, 1, '2018-08-13 17:22:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5565, 1, '2018-08-13 17:45:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5567, 1, '2018-08-13 17:46:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5569, 31, '2018-08-13 17:47:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5571, 33, '2018-08-13 17:48:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5573, 1, '2018-08-13 17:48:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5575, 35, '2018-08-13 17:49:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5577, 31, '2018-08-13 17:54:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5579, 33, '2018-08-13 17:55:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5581, 35, '2018-08-13 17:56:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5583, 1, '2018-08-13 17:57:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5585, 35, '2018-08-13 17:58:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5587, 1, '2018-08-14 08:36:47', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5589, 1, '2018-08-14 09:12:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5591, 35, '2018-08-14 09:23:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5593, 1, '2018-08-14 09:37:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5595, 35, '2018-08-14 09:42:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5597, 33, '2018-08-14 10:38:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5599, 33, '2018-08-14 11:01:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5601, 1, '2018-08-14 13:11:40', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5603, 1, '2018-08-14 13:26:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5605, 33, '2018-08-14 13:35:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5607, 1, '2018-08-14 13:49:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5609, 31, '2018-08-14 14:43:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5611, 33, '2018-08-14 14:45:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5613, 35, '2018-08-14 14:46:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5615, 35, '2018-08-14 14:46:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5617, 31, '2018-08-14 14:46:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5619, 33, '2018-08-14 14:47:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5621, 31, '2018-08-14 14:47:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5623, 33, '2018-08-14 15:04:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5625, 35, '2018-08-14 15:05:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5627, 33, '2018-08-14 15:06:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5629, 31, '2018-08-14 15:13:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5631, 35, '2018-08-14 15:14:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5633, 31, '2018-08-14 15:14:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5635, 33, '2018-08-14 15:15:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5637, 35, '2018-08-14 15:16:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5639, 31, '2018-08-14 15:22:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5641, 33, '2018-08-14 15:22:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5643, 35, '2018-08-14 15:23:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5645, 31, '2018-08-14 15:23:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5647, 1, '2018-08-14 15:23:42', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5649, 31, '2018-08-14 15:49:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5651, 33, '2018-08-14 15:56:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5653, 31, '2018-08-14 15:56:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5655, 33, '2018-08-14 16:17:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5657, 35, '2018-08-14 16:17:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5659, 31, '2018-08-14 16:18:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5661, 33, '2018-08-14 16:18:52', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5663, 35, '2018-08-14 16:19:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5665, 1, '2018-08-14 16:25:42', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5667, 1, '2018-08-14 16:25:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5669, 31, '2018-08-14 16:35:04', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5671, 33, '2018-08-14 16:35:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5673, 35, '2018-08-14 16:36:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5675, 31, '2018-08-14 16:40:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5677, 1, '2018-08-14 16:40:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5679, 31, '2018-08-14 16:57:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5681, 33, '2018-08-14 17:29:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5683, 31, '2018-08-14 17:30:19', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5685, 33, '2018-08-14 17:57:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5687, 31, '2018-08-14 18:08:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5689, 33, '2018-08-14 18:11:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5691, 31, '2018-08-14 18:12:08', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5693, 35, '2018-08-14 18:13:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5695, 1, '2018-08-15 10:12:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5697, 31, '2018-08-15 14:22:45', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5699, 33, '2018-08-15 14:27:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5701, 31, '2018-08-15 14:27:53', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5703, 33, '2018-08-15 14:41:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5705, 1, '2018-08-15 14:49:05', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5707, 1, '2018-08-15 16:02:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5709, 31, '2018-08-15 18:08:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5711, 33, '2018-08-15 18:09:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5713, 35, '2018-08-15 18:09:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5715, 31, '2018-08-15 18:10:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5717, 33, '2018-08-15 18:10:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5719, 31, '2018-08-15 18:11:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5721, 33, '2018-08-15 18:11:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5723, 1, '2018-08-15 18:26:16', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5725, 1, '2018-08-16 09:00:55', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5727, 1, '2018-08-16 09:18:09', '未知区域', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5729, 31, '2018-08-16 09:44:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5731, 31, '2018-08-16 18:05:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5733, 35, '2018-08-16 18:06:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5735, 1, '2018-08-17 09:08:14', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5737, 1, '2018-08-17 17:15:49', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5739, 31, '2018-08-20 10:54:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5741, 33, '2018-08-20 10:55:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5743, 35, '2018-08-20 10:56:02', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5745, 33, '2018-08-20 10:56:24', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5747, 31, '2018-08-20 10:57:48', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5749, 33, '2018-08-20 10:58:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5751, 1, '2018-08-20 14:54:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5753, 1, '2018-08-20 16:24:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5755, 31, '2018-08-20 17:05:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5757, 1, '2018-08-20 17:27:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5759, 1, '2018-08-22 10:26:59', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5761, 13, '2018-08-22 10:50:17', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5763, 1, '2018-08-22 13:33:35', '未知区域', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5765, 13, '2018-08-22 13:39:45', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5767, 1, '2018-08-22 13:44:25', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5769, 1, '2018-08-22 14:21:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5771, 31, '2018-08-22 15:02:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5773, 31, '2018-08-27 09:46:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5775, 1, '2018-08-28 17:19:58', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5777, 55, '2018-08-28 17:49:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5779, 1, '2018-08-28 18:00:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5781, 55, '2018-08-29 16:19:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5783, 1, '2018-08-29 16:21:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5785, 33, '2018-08-29 16:22:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5787, 1, '2018-08-29 16:23:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5789, 1, '2018-08-29 16:37:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5791, 1, '2018-08-29 16:42:02', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5793, 1, '2018-08-29 16:44:14', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5795, 1, '2018-08-29 16:50:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5797, 1, '2018-08-29 16:51:19', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5799, 1, '2018-08-29 16:53:03', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5801, 1, '2018-08-29 16:53:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5803, 1, '2018-08-29 16:53:57', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5805, 1, '2018-08-29 17:01:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5807, 55, '2018-08-29 17:26:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5809, 1, '2018-08-29 17:27:32', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5811, 1, '2018-08-29 17:35:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5813, 1, '2018-08-29 17:39:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5815, 1, '2018-08-30 09:32:20', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5817, 55, '2018-08-30 11:41:22', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5819, 1, '2018-08-30 13:30:55', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5821, 1, '2018-08-30 13:45:56', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5823, 1, '2018-08-30 13:53:39', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5825, 1, '2018-08-30 13:57:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5827, 1, '2018-08-30 15:21:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5829, 1, '2018-08-30 15:25:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5831, 55, '2018-08-30 16:48:41', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5833, 33, '2018-08-30 16:49:24', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (5835, 1, '2018-08-30 16:52:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5837, 33, '2018-08-30 17:05:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5839, 31, '2018-08-31 09:17:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5841, 1, '2018-08-31 10:32:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5843, 1, '2018-09-03 09:25:15', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5845, 1, '2018-09-03 10:24:28', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5847, 1, '2018-09-03 11:22:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5849, 31, '2018-09-03 13:23:34', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5851, 31, '2018-09-03 13:28:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5853, 31, '2018-09-03 13:29:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5855, 1, '2018-09-03 13:33:18', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5857, 33, '2018-09-03 13:36:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5859, 31, '2018-09-03 13:40:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5861, 35, '2018-09-03 13:44:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5863, 35, '2018-09-03 13:46:03', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5865, 33, '2018-09-03 13:52:58', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5867, 1, '2018-09-03 14:12:29', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5869, 1, '2018-09-03 15:39:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5871, 1, '2018-09-03 15:42:00', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5873, 1, '2018-09-04 09:23:07', '鍐呯綉IP鍐呯綉IP', '192.168.1.67', '电脑');
INSERT INTO `sys_landing_records` VALUES (5875, 31, '2018-09-05 09:14:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5877, 31, '2018-09-06 09:57:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5879, 33, '2018-09-06 11:20:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5881, 1, '2018-09-06 12:19:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5883, 1, '2018-09-06 12:21:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5885, 1, '2018-09-06 12:32:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5887, 31, '2018-09-06 13:16:49', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5889, 33, '2018-09-06 13:17:11', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5891, 31, '2018-09-06 13:19:51', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5893, 33, '2018-09-06 13:20:18', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5895, 1, '2018-09-06 13:20:44', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5897, 1, '2018-09-13 10:24:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5899, 1, '2018-09-19 11:47:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5901, 1, '2018-09-19 13:45:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5903, 1, '2018-09-19 13:47:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5905, 33, '2018-09-19 13:48:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5907, 1, '2018-09-19 13:48:30', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5909, 33, '2018-09-19 13:49:12', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5911, 1, '2018-09-19 16:23:18', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5913, 1, '2018-09-20 16:23:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5915, 1, '2018-09-20 16:27:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5917, 1, '2018-09-20 16:36:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5919, 1, '2018-09-20 16:42:37', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5921, 31, '2018-09-21 10:07:07', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5923, 31, '2018-09-21 10:29:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5925, 1, '2018-09-21 11:35:41', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5927, 33, '2018-09-21 11:36:10', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5929, 1, '2018-09-21 11:38:27', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5931, 31, '2018-09-21 11:39:01', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5933, 33, '2018-09-21 11:39:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5935, 33, '2018-09-21 14:29:05', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5937, 33, '2018-09-21 15:05:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5939, 31, '2018-09-21 15:31:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5941, 31, '2018-09-21 15:42:57', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5943, 1, '2018-09-21 15:47:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5945, 33, '2018-09-21 16:03:22', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5947, 33, '2018-09-21 16:05:28', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5949, 31, '2018-09-21 16:31:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5951, 1, '2018-09-21 16:32:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5953, 1, '2018-09-25 10:44:50', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5955, 1, '2018-09-27 09:53:40', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5957, 1, '2018-09-27 09:53:59', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5959, 1, '2018-09-27 10:06:33', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5961, 1, '2018-09-27 10:06:47', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5963, 1, '2018-09-27 10:11:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5965, 1, '2018-09-27 10:12:39', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5967, 1, '2018-09-28 10:17:09', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5969, 1, '2018-09-28 16:22:56', '内网IP内网IP', '192.168.1.66', '电脑');
INSERT INTO `sys_landing_records` VALUES (5971, 1, '2018-09-28 16:26:17', '内网IP内网IP', '192.168.1.66', '电脑');
INSERT INTO `sys_landing_records` VALUES (5973, 1, '2018-09-28 16:27:43', '内网IP内网IP', '192.168.1.65', '电脑');
INSERT INTO `sys_landing_records` VALUES (5975, 1, '2018-09-28 16:29:26', '内网IP内网IP', '192.168.1.69', '电脑');
INSERT INTO `sys_landing_records` VALUES (5977, 1, '2018-09-28 16:53:38', '内网IP内网IP', '192.168.1.66', '电脑');
INSERT INTO `sys_landing_records` VALUES (5979, 1, '2018-09-28 17:05:15', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5981, 1, '2018-09-29 11:50:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5983, 1, '2018-09-29 15:57:56', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5985, 1, '2018-09-29 17:16:17', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5987, 1, '2018-09-30 14:23:25', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5989, 1, '2018-09-30 15:04:43', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5991, 1, '2018-10-08 11:05:16', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5993, 1, '2018-10-09 16:34:26', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5995, 1, '2018-10-09 16:39:23', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5997, 1, '2018-10-09 16:40:13', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (5999, 55, '2018-10-09 16:41:46', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6001, 1, '2018-10-09 16:43:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6003, 55, '2018-10-09 16:45:36', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6005, 1, '2018-10-09 16:46:32', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6007, 55, '2018-10-09 16:47:35', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6009, 1, '2018-10-26 15:55:36', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6011, 55, '2018-10-26 15:56:46', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6013, 55, '2018-10-26 16:45:21', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6015, 55, '2018-10-26 16:46:00', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6017, 1, '2018-10-26 16:48:50', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6019, 1, '2018-10-26 17:08:34', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6021, 55, '2018-10-26 17:08:49', '鍐呯綉IP鍐呯綉IP', '127.0.0.1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6023, 1, '2018-10-29 15:08:52', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6025, 71, '2018-10-29 15:11:05', '未知区域', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6027, 71, '2018-10-29 15:13:26', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6029, 71, '2018-10-29 15:40:06', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6031, 33, '2018-10-29 15:42:33', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6033, 37, '2018-10-29 15:44:30', '鍐呯綉IP鍐呯綉IP', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6035, 39, '2018-10-29 15:46:08', '未知区域', '192.168.1.73', '电脑');
INSERT INTO `sys_landing_records` VALUES (6037, 1, '2018-11-29 10:10:20', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6038, 1, '2018-12-09 16:59:21', '未知区域', '0:0:0:0:0:0:0:1', '电脑');
INSERT INTO `sys_landing_records` VALUES (6039, 1, '2018-12-26 17:01:38', '未知区域', '0:0:0:0:0:0:0:1', '电脑');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `time` int(11) NULL DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `device_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '访问方式 0:PC 1:手机 2:未知',
  `log_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '类型 0: 一般日志记录 1: 异常错误日志',
  `exception_detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常详细信息',
  `gmt_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85119 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (85118, 1, 'admin', '清空日志', 78, 'com.acts.market.common.controller.SysLogController.batchRemoveAll()', NULL, '0:0:0:0:0:0:0:1', 0, 0, NULL, '2018-12-26 17:02:07');

-- ----------------------------
-- Table structure for sys_macro
-- ----------------------------
DROP TABLE IF EXISTS `sys_macro`;
CREATE TABLE `sys_macro`  (
  `macro_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(255) NULL DEFAULT NULL COMMENT '父级id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态，0：隐藏   1：显示',
  `type` tinyint(20) NULL DEFAULT NULL COMMENT '类型,0:目录，1:参数配置',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`macro_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通用字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_macro
-- ----------------------------
INSERT INTO `sys_macro` VALUES (1, 0, '系统参数', NULL, 1, 0, 0, NULL, '2017-08-15 14:51:27', NULL);
INSERT INTO `sys_macro` VALUES (2, 1, '用户状态', 'userStatus', 1, 0, 0, NULL, '2017-08-15 14:51:30', NULL);
INSERT INTO `sys_macro` VALUES (3, 2, '正常', '1', 0, 1, 0, '用户可登录', '2017-08-15 14:52:48', '2017-08-15 20:23:29');
INSERT INTO `sys_macro` VALUES (4, 2, '禁用', '0', 1, 1, 0, '禁止用户登录', '2017-08-15 14:52:51', '2017-08-15 20:44:42');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 280 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, '', 0, 'layui-icon layui-icon-template-1', 0, '2017-08-09 22:49:47', '2017-09-11 17:25:22');
INSERT INTO `sys_menu` VALUES (2, 1, '系统菜单', 'sys/menu/list.html', NULL, 1, 'layui-icon layui-icon-spread-left', 10, '2017-08-09 22:55:15', '2017-08-17 10:00:12');
INSERT INTO `sys_menu` VALUES (3, 0, '组织机构', NULL, NULL, 0, 'layui-icon layui-icon-group', 1, '2017-08-09 23:06:55', '2017-08-17 09:54:28');
INSERT INTO `sys_menu` VALUES (4, 1, '通用字典', 'sys/macro/list.html', NULL, 1, 'layui-icon layui-icon-note', 2, '2017-08-09 23:06:58', '2017-08-17 10:00:24');
INSERT INTO `sys_menu` VALUES (6, 3, '用户管理', 'sys/user/list.html', '', 1, 'layui-icon layui-icon-username', 2, '2017-08-10 14:12:11', '2017-09-05 12:57:42');
INSERT INTO `sys_menu` VALUES (7, 3, '角色管理', 'sys/role/list.html', '', 1, 'layui-icon layui-icon-tree', 1, '2017-08-10 14:13:19', '2017-09-05 12:57:30');
INSERT INTO `sys_menu` VALUES (11, 6, '刷新', '/sys/user/list', 'sys:user:list', 2, NULL, 0, '2017-08-14 10:51:05', '2017-09-05 12:47:23');
INSERT INTO `sys_menu` VALUES (12, 6, '新增', '/sys/user/save', 'sys:user:save', 2, NULL, 0, '2017-08-14 10:51:35', '2017-09-05 12:47:34');
INSERT INTO `sys_menu` VALUES (13, 6, '编辑', '/sys/user/update', 'sys:user:edit', 2, NULL, 0, '2017-08-14 10:52:06', '2017-09-05 12:47:46');
INSERT INTO `sys_menu` VALUES (14, 6, '删除', '/sys/user/remove', 'sys:user:remove', 2, NULL, 0, '2017-08-14 10:52:24', '2017-09-05 12:48:03');
INSERT INTO `sys_menu` VALUES (15, 7, '刷新', '/sys/role/list', 'sys:role:list', 2, NULL, 0, '2017-08-14 10:56:37', '2017-09-05 12:44:04');
INSERT INTO `sys_menu` VALUES (16, 7, '新增', '/sys/role/save', 'sys:role:save', 2, NULL, 0, '2017-08-14 10:57:02', '2017-09-05 12:44:23');
INSERT INTO `sys_menu` VALUES (17, 7, '编辑', '/sys/role/update', 'sys:role:edit', 2, NULL, 0, '2017-08-14 10:57:31', '2017-09-05 12:44:48');
INSERT INTO `sys_menu` VALUES (18, 7, '删除', '/sys/role/remove', 'sys:role:remove', 2, NULL, 0, '2017-08-14 10:57:50', '2017-09-05 12:45:02');
INSERT INTO `sys_menu` VALUES (19, 7, '操作权限', '/sys/role/authorize/opt', 'sys:role:authorizeOpt', 2, NULL, 0, '2017-08-14 10:58:55', '2017-09-05 12:45:29');
INSERT INTO `sys_menu` VALUES (20, 2, '刷新', '/sys/menu/list', 'sys:menu:list', 2, NULL, 0, '2017-08-14 10:59:32', '2017-09-05 13:06:24');
INSERT INTO `sys_menu` VALUES (21, 2, '新增', '/sys/menu/save', 'sys:menu:save', 2, NULL, 0, '2017-08-14 10:59:56', '2017-09-05 13:06:35');
INSERT INTO `sys_menu` VALUES (22, 2, '编辑', '/sys/menu/update', 'sys:menu:edit', 2, NULL, 0, '2017-08-14 11:00:26', '2017-09-05 13:06:48');
INSERT INTO `sys_menu` VALUES (23, 2, '删除', '/sys/menu/remove', 'sys:menu:remove', 2, NULL, 0, '2017-08-14 11:00:58', '2017-09-05 13:07:00');
INSERT INTO `sys_menu` VALUES (24, 6, '启用', '/sys/user/enable', 'sys:user:enable', 2, NULL, 0, '2017-08-14 17:27:18', '2017-09-05 12:48:30');
INSERT INTO `sys_menu` VALUES (25, 6, '停用', '/sys/user/disable', 'sys:user:disable', 2, NULL, 0, '2017-08-14 17:27:43', '2017-09-05 12:48:49');
INSERT INTO `sys_menu` VALUES (26, 6, '重置密码', '/sys/user/rest', 'sys:user:resetPassword', 2, NULL, 0, '2017-08-14 17:28:34', '2017-09-05 12:49:17');
INSERT INTO `sys_menu` VALUES (27, 267, '系统日志', 'sys/log/list.html', NULL, 1, 'fa fa-warning', 3, '2017-08-14 22:11:53', '2017-08-17 09:55:19');
INSERT INTO `sys_menu` VALUES (28, 27, '刷新', '/sys/log/list', 'sys:log:list', 2, NULL, 0, '2017-08-14 22:30:22', '2017-09-05 13:05:24');
INSERT INTO `sys_menu` VALUES (29, 27, '删除', '/sys/log/remove', 'sys:log:remove', 2, NULL, 0, '2017-08-14 22:30:43', '2017-09-05 13:05:37');
INSERT INTO `sys_menu` VALUES (30, 27, '清空', '/sys/log/clear', 'sys:log:clear', 2, NULL, 0, '2017-08-14 22:31:02', '2017-09-05 13:05:53');
INSERT INTO `sys_menu` VALUES (32, 4, '刷新', '/sys/macro/list', 'sys:macro:list', 2, NULL, 0, '2017-08-15 16:55:33', '2017-09-05 13:04:00');
INSERT INTO `sys_menu` VALUES (33, 4, '新增', '/sys/macro/save', 'sys:macro:save', 2, NULL, 0, '2017-08-15 16:55:52', '2017-09-05 13:04:22');
INSERT INTO `sys_menu` VALUES (34, 4, '编辑', '/sys/macro/update', 'sys:macro:edit', 2, NULL, 0, '2017-08-15 16:56:09', '2017-09-05 13:04:36');
INSERT INTO `sys_menu` VALUES (35, 4, '删除', '/sys/macro/remove', 'sys:macro:remove', 2, NULL, 0, '2017-08-15 16:56:29', '2017-09-05 13:04:49');
INSERT INTO `sys_menu` VALUES (37, 3, '行政区域', 'sys/area/list.html', '', 1, 'layui-icon layui-icon-face-surprised', 0, '2017-08-17 09:59:57', '2017-09-05 12:49:47');
INSERT INTO `sys_menu` VALUES (38, 37, '刷新', '/sys/area/list', 'sys:area:list', 2, NULL, 0, '2017-08-17 10:01:33', '2017-09-05 13:00:54');
INSERT INTO `sys_menu` VALUES (39, 37, '新增', '/sys/area/save', 'sys:area:save', 2, NULL, 0, '2017-08-17 10:02:16', '2017-09-05 13:01:06');
INSERT INTO `sys_menu` VALUES (40, 37, '编辑', '/sys/area/update', 'sys:area:edit', 2, NULL, 0, '2017-08-17 10:02:33', '2017-09-05 13:01:21');
INSERT INTO `sys_menu` VALUES (41, 37, '删除', '/sys/area/remove', 'sys:area:remove', 2, NULL, 0, '2017-08-17 10:02:50', '2017-09-05 13:01:32');
INSERT INTO `sys_menu` VALUES (42, 261, '刷新', '/sys/org/list', 'sys:org:list', 2, NULL, 0, '2017-08-17 10:03:36', '2017-09-05 11:47:37');
INSERT INTO `sys_menu` VALUES (43, 261, '新增', '/sys/org/save', 'sys:org:save', 2, NULL, 0, '2017-08-17 10:03:54', '2017-09-05 12:40:55');
INSERT INTO `sys_menu` VALUES (44, 261, '编辑', '/sys/org/update', 'sys:org:edit', 2, NULL, 0, '2017-08-17 10:04:11', '2017-09-05 12:43:06');
INSERT INTO `sys_menu` VALUES (45, 261, '删除', '/sys/org/remove', 'sys:org:remove', 2, NULL, 0, '2017-08-17 10:04:30', '2017-09-05 12:42:19');
INSERT INTO `sys_menu` VALUES (46, 7, '数据权限', '/sys/role/authorize/data', 'sys:role:authorizeData', 2, NULL, 0, '2017-08-17 13:48:11', '2017-09-05 12:45:54');
INSERT INTO `sys_menu` VALUES (59, 1, '敏捷开发', 'app/gen/list.html', NULL, 1, 'layui-icon layui-icon-flag', 0, '2017-09-05 10:49:04', NULL);
INSERT INTO `sys_menu` VALUES (60, 59, '刷新', '/sys/generator/list', 'sys:gen:list', 2, NULL, 0, '2017-09-05 10:49:25', '2017-09-05 13:07:33');
INSERT INTO `sys_menu` VALUES (61, 59, '生成代码', '/sys/generator/code', 'sys:gen:code', 2, NULL, 0, '2017-09-05 10:49:44', '2017-09-05 13:07:48');
INSERT INTO `sys_menu` VALUES (95, 1, '通知通告', 'app/notice/list.html', NULL, 1, 'layui-icon layui-icon-notice', 30, NULL, NULL);
INSERT INTO `sys_menu` VALUES (97, 95, '刷新', NULL, 'oa:notify:list', 2, 'fa fa-file-code-o', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (99, 95, '新增', NULL, 'oa:notify:save', 2, 'fa fa-file-code-o', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (101, 95, '修改', NULL, 'oa:notify:edit', 2, 'fa fa-file-code-o', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (123, 267, '在线用户', 'sys/user/online.html', NULL, 1, 'fa fa-group', 0, '2018-01-11 16:32:44', NULL);
INSERT INTO `sys_menu` VALUES (145, 123, '查看', NULL, 'sys:session:list', 2, NULL, 0, '2018-05-09 09:58:49', '2018-05-09 14:40:22');
INSERT INTO `sys_menu` VALUES (260, 266, '任务调度', '/app/task/list.html', NULL, 1, 'layui-icon layui-icon-set', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (261, 3, '机构管理', '/sys/org/list.html', NULL, 1, 'layui-icon layui-icon-group', 3, NULL, NULL);
INSERT INTO `sys_menu` VALUES (264, 1, '全局配置', 'sys/config/list.html', NULL, 1, 'layui-icon layui-icon-templeate-1', 40, NULL, NULL);
INSERT INTO `sys_menu` VALUES (265, 266, '邮件管理', '/app/email/list.html', NULL, 1, 'layui-icon layui-icon-template-1', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (266, 0, '应用管理', '', NULL, 0, 'layui-icon layui-icon-find-fill', 2, NULL, NULL);
INSERT INTO `sys_menu` VALUES (267, 0, '系统监控', NULL, NULL, 0, 'layui-icon layui-icon-camera', 3, NULL, NULL);
INSERT INTO `sys_menu` VALUES (268, 266, '图片管理', '/app/image/list.html', NULL, 1, 'layui-icon layui-icon-picture', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (269, 266, '文章管理', '/app/article/list.html', NULL, 1, 'layui-icon layui-icon-list', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (270, 266, '图片上传', 'app/image/upload.html', NULL, 1, 'layui-icon layui-icon-face-smile', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (271, 266, '短链生成', 'app/tinyUrl/list.html', NULL, 1, 'layui-icon layui-icon-senior', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (272, 266, '语音合成', 'app/ai/voice.html', NULL, 1, 'layui-icon layui-icon-dialogue', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (273, 1, '文件管理', 'sys/file/list.html', NULL, 1, 'layui-icon layui-icon-fonts-code', 20, NULL, NULL);
INSERT INTO `sys_menu` VALUES (274, 266, '接口管理', 'swagger-ui.html', NULL, 1, 'layui-icon layui-icon-vercode', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (275, 0, '爪哇妹子', NULL, NULL, 0, 'layui-icon layui-icon-female', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (276, 275, '授权用户', 'weChat/user/list.html', NULL, 1, 'layui-icon layui-icon-username', 1, NULL, NULL);
INSERT INTO `sys_menu` VALUES (277, 275, '每日推荐', 'weChat/recommend/list.html', NULL, 1, 'layui-icon layui-icon-fire', 2, NULL, NULL);
INSERT INTO `sys_menu` VALUES (278, 275, '爪哇妹图', 'weChat/meizi/list.html', NULL, 1, 'layui-icon layui-icon-picture', 3, NULL, NULL);
INSERT INTO `sys_menu` VALUES (279, 266, '数据查询', 'app/query/list.html', NULL, 1, 'layui-icon layui-icon-search', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `org_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '机构id',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级机构ID，一级机构为0',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `full_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构名称(全称)',
  `director` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构负责人',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '可用标识  1：可用  0：不可用',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`org_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '机构管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (36, 0, '00006', '青岛海信', '青岛海信', '海信', NULL, NULL, NULL, NULL, 1, '2020-05-08 22:06:58', '2020-05-08 22:07:03');
INSERT INTO `sys_org` VALUES (38, 0, '00005', '青岛海尔', '青岛海尔', NULL, NULL, NULL, NULL, NULL, 1, '2020-05-08 22:17:32', '2020-05-22 22:46:07');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `org_id` bigint(255) NULL DEFAULT NULL COMMENT '所属机构',
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint(255) NULL DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 17, '超级管理员', 'admin', '【系统内置】', 2, '2017-08-12 00:43:52', '2017-11-21 10:19:08');
INSERT INTO `sys_role` VALUES (2, -1, '机构管理员', 'orgAdmin', NULL, 1, '2020-05-08 22:31:29', '2020-05-08 22:57:28');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14115 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (13468, 2, 3);
INSERT INTO `sys_role_menu` VALUES (13469, 2, 261);
INSERT INTO `sys_role_menu` VALUES (13470, 2, 42);
INSERT INTO `sys_role_menu` VALUES (13471, 2, 43);
INSERT INTO `sys_role_menu` VALUES (13472, 2, 44);
INSERT INTO `sys_role_menu` VALUES (13473, 2, 45);
INSERT INTO `sys_role_menu` VALUES (13474, 2, 6);
INSERT INTO `sys_role_menu` VALUES (13475, 2, 11);
INSERT INTO `sys_role_menu` VALUES (13476, 2, 12);
INSERT INTO `sys_role_menu` VALUES (13477, 2, 13);
INSERT INTO `sys_role_menu` VALUES (13478, 2, 14);
INSERT INTO `sys_role_menu` VALUES (13479, 2, 24);
INSERT INTO `sys_role_menu` VALUES (13480, 2, 25);
INSERT INTO `sys_role_menu` VALUES (13481, 2, 26);
INSERT INTO `sys_role_menu` VALUES (13482, 2, 7);
INSERT INTO `sys_role_menu` VALUES (13483, 2, 15);
INSERT INTO `sys_role_menu` VALUES (13484, 2, 16);
INSERT INTO `sys_role_menu` VALUES (13485, 2, 17);
INSERT INTO `sys_role_menu` VALUES (13486, 2, 18);
INSERT INTO `sys_role_menu` VALUES (13487, 2, 19);
INSERT INTO `sys_role_menu` VALUES (13488, 2, 46);
INSERT INTO `sys_role_menu` VALUES (13489, 2, 37);
INSERT INTO `sys_role_menu` VALUES (13490, 2, 38);
INSERT INTO `sys_role_menu` VALUES (13491, 2, 39);
INSERT INTO `sys_role_menu` VALUES (13492, 2, 40);
INSERT INTO `sys_role_menu` VALUES (13493, 2, 41);
INSERT INTO `sys_role_menu` VALUES (14053, 1, 267);
INSERT INTO `sys_role_menu` VALUES (14054, 1, 27);
INSERT INTO `sys_role_menu` VALUES (14055, 1, 28);
INSERT INTO `sys_role_menu` VALUES (14056, 1, 29);
INSERT INTO `sys_role_menu` VALUES (14057, 1, 30);
INSERT INTO `sys_role_menu` VALUES (14058, 1, 123);
INSERT INTO `sys_role_menu` VALUES (14059, 1, 145);
INSERT INTO `sys_role_menu` VALUES (14060, 1, 266);
INSERT INTO `sys_role_menu` VALUES (14061, 1, 260);
INSERT INTO `sys_role_menu` VALUES (14062, 1, 265);
INSERT INTO `sys_role_menu` VALUES (14063, 1, 268);
INSERT INTO `sys_role_menu` VALUES (14064, 1, 269);
INSERT INTO `sys_role_menu` VALUES (14065, 1, 270);
INSERT INTO `sys_role_menu` VALUES (14066, 1, 271);
INSERT INTO `sys_role_menu` VALUES (14067, 1, 272);
INSERT INTO `sys_role_menu` VALUES (14068, 1, 274);
INSERT INTO `sys_role_menu` VALUES (14069, 1, 279);
INSERT INTO `sys_role_menu` VALUES (14070, 1, 3);
INSERT INTO `sys_role_menu` VALUES (14071, 1, 261);
INSERT INTO `sys_role_menu` VALUES (14072, 1, 42);
INSERT INTO `sys_role_menu` VALUES (14073, 1, 43);
INSERT INTO `sys_role_menu` VALUES (14074, 1, 44);
INSERT INTO `sys_role_menu` VALUES (14075, 1, 45);
INSERT INTO `sys_role_menu` VALUES (14076, 1, 6);
INSERT INTO `sys_role_menu` VALUES (14077, 1, 11);
INSERT INTO `sys_role_menu` VALUES (14078, 1, 12);
INSERT INTO `sys_role_menu` VALUES (14079, 1, 13);
INSERT INTO `sys_role_menu` VALUES (14080, 1, 14);
INSERT INTO `sys_role_menu` VALUES (14081, 1, 24);
INSERT INTO `sys_role_menu` VALUES (14082, 1, 25);
INSERT INTO `sys_role_menu` VALUES (14083, 1, 26);
INSERT INTO `sys_role_menu` VALUES (14084, 1, 7);
INSERT INTO `sys_role_menu` VALUES (14085, 1, 15);
INSERT INTO `sys_role_menu` VALUES (14086, 1, 16);
INSERT INTO `sys_role_menu` VALUES (14087, 1, 17);
INSERT INTO `sys_role_menu` VALUES (14088, 1, 18);
INSERT INTO `sys_role_menu` VALUES (14089, 1, 19);
INSERT INTO `sys_role_menu` VALUES (14090, 1, 46);
INSERT INTO `sys_role_menu` VALUES (14091, 1, 37);
INSERT INTO `sys_role_menu` VALUES (14092, 1, 38);
INSERT INTO `sys_role_menu` VALUES (14093, 1, 39);
INSERT INTO `sys_role_menu` VALUES (14094, 1, 40);
INSERT INTO `sys_role_menu` VALUES (14095, 1, 41);
INSERT INTO `sys_role_menu` VALUES (14096, 1, 1);
INSERT INTO `sys_role_menu` VALUES (14097, 1, 264);
INSERT INTO `sys_role_menu` VALUES (14098, 1, 95);
INSERT INTO `sys_role_menu` VALUES (14099, 1, 97);
INSERT INTO `sys_role_menu` VALUES (14100, 1, 99);
INSERT INTO `sys_role_menu` VALUES (14101, 1, 101);
INSERT INTO `sys_role_menu` VALUES (14102, 1, 273);
INSERT INTO `sys_role_menu` VALUES (14103, 1, 2);
INSERT INTO `sys_role_menu` VALUES (14104, 1, 20);
INSERT INTO `sys_role_menu` VALUES (14105, 1, 21);
INSERT INTO `sys_role_menu` VALUES (14106, 1, 22);
INSERT INTO `sys_role_menu` VALUES (14107, 1, 23);
INSERT INTO `sys_role_menu` VALUES (14108, 1, 59);
INSERT INTO `sys_role_menu` VALUES (14109, 1, 60);
INSERT INTO `sys_role_menu` VALUES (14110, 1, 61);
INSERT INTO `sys_role_menu` VALUES (14111, 1, 275);
INSERT INTO `sys_role_menu` VALUES (14112, 1, 278);
INSERT INTO `sys_role_menu` VALUES (14113, 1, 277);
INSERT INTO `sys_role_menu` VALUES (14114, 1, 276);

-- ----------------------------
-- Table structure for sys_role_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_org`;
CREATE TABLE `sys_role_org`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `org_id` bigint(20) NULL DEFAULT NULL COMMENT '机构ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与机构对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_org
-- ----------------------------
INSERT INTO `sys_role_org` VALUES (17, 1, 17);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `org_id` bigint(20) NOT NULL COMMENT '所属机构',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名(昵称)',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `avatar_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '头像上传 0:未上传 1:上传',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint(255) NULL DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `is_modify_pwd` tinyint(4) NULL DEFAULT 0 COMMENT '是否修改过初始密码',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 36, 'admin', '31abb6bf3429d1e8fdec0b766872878a', 'admin', '100000@qq.com', '17752859653', 1, 0, NULL, 1, '2017-08-15 21:40:39', '2020-05-11 21:55:19', 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 256 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (254, 1, 2);
INSERT INTO `sys_user_role` VALUES (255, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
