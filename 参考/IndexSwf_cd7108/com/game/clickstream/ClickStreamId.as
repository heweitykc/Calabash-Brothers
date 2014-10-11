package com.game.clickstream
{

    public class ClickStreamId extends Object
    {
        public var id:uint;
        public var name:String;
        public static var FLASH_STARTUP:ClickStreamId = new ClickStreamId(1, "进入游戏 - flash启动");
        public static var CONNECT_SERVER_OK:ClickStreamId = new ClickStreamId(2, "进入游戏 - 成功连接服务器");
        public static var LOGIN_USER_OK:ClickStreamId = new ClickStreamId(3, "进入游戏 - 成功登入账号");
        public static var START_LOAD_REGIST_VIEW:ClickStreamId = new ClickStreamId(30001, "开始加载创角界面");
        public static var SHOW_REGIST_VIEW:ClickStreamId = new ClickStreamId(4, "进入游戏 - 进入创角界面");
        public static var CHOOSE_JOB:ClickStreamId = new ClickStreamId(5, "进入游戏 - 选择职业");
        public static var RANDOM_NAME:ClickStreamId = new ClickStreamId(6, "进入游戏 - 随机名称");
        public static var INPUT_NAME:ClickStreamId = new ClickStreamId(7, "进入游戏 - 输入名称");
        public static var REGIST:ClickStreamId = new ClickStreamId(8, "进入游戏 - 点击创角按钮");
        public static var LOGIN_PLAYER_OK:ClickStreamId = new ClickStreamId(9, "进入游戏 - 成功登录角色");
        public static var LOAD_RESOURCE_OK:ClickStreamId = new ClickStreamId(10, "进入游戏 - 加载初期资源");
        public static var LOAD_MAP_RESOURCE_START:ClickStreamId = new ClickStreamId(11, "进入游戏 - 开始加载地图资源");
        public static var LOAD_MAP_RESOURCE_OK:ClickStreamId = new ClickStreamId(12, "进入游戏 - 成功加载地图资源");
        public static var ENTER_MAP:ClickStreamId = new ClickStreamId(13, "进入游戏 - 进入地图");
        public static var START_JOURNEY:ClickStreamId = new ClickStreamId(14, "进入游戏 - 开始旅程");
        public static var OPEN_ZuoQi:ClickStreamId = new ClickStreamId(15, "坐骑 - 打开坐骑界面");
        public static var CLICK_ZuoQi_XunYang:ClickStreamId = new ClickStreamId(16, "坐骑 - 点击驯养按钮");
        public static var CLICK_ZuoQi_ZiDongXunYang:ClickStreamId = new ClickStreamId(17, "坐骑 - 点击自动驯养按钮");
        public static var CLICK_TuiJianJiaDian:ClickStreamId = new ClickStreamId(18, "人物-加点 - 点击推荐加点按钮");
        public static var CLICK_JiaDian:ClickStreamId = new ClickStreamId(19, "人物-加点 - 点击加点按钮");
        public static var OPEN_QiangHua:ClickStreamId = new ClickStreamId(20, "强化 - 打开强化界面");
        public static var OPEN_ZuiJia:ClickStreamId = new ClickStreamId(21, "强化 - 打开追加界面");
        public static var CLICK_QiangHua_QiangHua:ClickStreamId = new ClickStreamId(22, "强化 - 点击强化按钮");
        public static var CLICK_ZuiJia_ZuiJia:ClickStreamId = new ClickStreamId(23, "强化 - 点击追加按钮");
        public static var OPEN_JiNeng:ClickStreamId = new ClickStreamId(24, "技能 - 打开技能界面");
        public static var OPEN_YiLuoJiNeng:ClickStreamId = new ClickStreamId(25, "技能 - 打开遗落技能界面");
        public static var CLICK_JiNeng_JiHuo:ClickStreamId = new ClickStreamId(26, "技能 - 点击激活按钮");
        public static var CLICK_JiNeng_ShengJi:ClickStreamId = new ClickStreamId(27, "技能 - 点击升级按钮");
        public static var CLICK_RiChangRenWu_LingQuJiangLi:ClickStreamId = new ClickStreamId(28, "日常任务 - 点击领取奖励按钮");
        public static var CLICK_Vip_LiJiKaiTong:ClickStreamId = new ClickStreamId(29, "VIP界面 - 点击立即开通按钮");
        public static var CLICK_DengJiJiangLi_LingQuJiangLi:ClickStreamId = new ClickStreamId(30, "等级奖励 - 点击领取奖励按钮");
        public static var OPEN_KaiFuHuoDong:ClickStreamId = new ClickStreamId(31, "开服活动 - 打开开服活动界面");
        public static var OPEN_ZhanDouZhuShou:ClickStreamId = new ClickStreamId(32, "战斗助手 - 打开战斗助手界面");
        public static var CLICK_ZhanDouZhuShou_XunHuanGuaJi:ClickStreamId = new ClickStreamId(33, "战斗助手 - 点击循环挂机按钮");
        public static var OPEN_ZhuanZhi:ClickStreamId = new ClickStreamId(34, "转职 - 打开转职界面");
        public static var CLICK_DiJingZhuZao_ZhuZao:ClickStreamId = new ClickStreamId(35, "地精铸造 - 点击铸造按钮");
        public static var CLICK_QianDao:ClickStreamId = new ClickStreamId(36, "签到 - 点击签到按钮");
        public static var CLICK_VipTiYan_LiJiXuFei:ClickStreamId = new ClickStreamId(37, "vip卡体验界面 - 点击立即续费按钮");
        public static var CLICK_MengChongXuFei_LijiQianWang:ClickStreamId = new ClickStreamId(38, "萌宠续费提醒界面 - 点击立即前往");
        public static var CLICK_ChiSeYaoSai_LiJiCanJia:ClickStreamId = new ClickStreamId(39, "赤色要塞界面 - 点击立即参加");
        public static var CLICK_GongChengZhan_ChuanSongJinRuZhanChang:ClickStreamId = new ClickStreamId(40, "攻城战界面 - 点击传送进入战场");
        public static var OPEN_TanWei:ClickStreamId = new ClickStreamId(41, "摊位 - 打开摊位界面");
        public static var OPEN_ZhanMeng:ClickStreamId = new ClickStreamId(42, "战盟 - 打开战盟界面");
        public static var OPEN_TouZi:ClickStreamId = new ClickStreamId(43, "投资 - 打开投资界面");
        public static var CLICK_ShangCheng_VipShangCheng:ClickStreamId = new ClickStreamId(44, "商城 - 点击VIP商城按钮");
        public static var OPEN_YouXiJianJie:ClickStreamId = new ClickStreamId(45, "游戏简介 - 打开游戏简介界面");
        public static var OPEN_DuiWu:ClickStreamId = new ClickStreamId(46, "队伍 - 打开队伍界面");
        public static var OPEN_BeiBao:ClickStreamId = new ClickStreamId(47, "背包 - 打开背包界面");
        public static var CLICK_ShouCiChongZhi_ChongDianXiaoQian:ClickStreamId = new ClickStreamId(48, "首次充值界面 - 点击\"充点小钱玩一玩\"按钮");
        public static var CLICK_DanBiChongZhi_ChongDianXiaoQian:ClickStreamId = new ClickStreamId(49, "单笔充值界面 - 点击\"充点小钱玩一玩\"按钮");
        public static var CLICK_SWITCHMAP_YongZheDaLu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(50, "立即传送 - 从勇者大陆传送到地下城一层");
        public static var FINISH_SWITCHMAP_YongZheDaLu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(51, "传送成功 - 从勇者大陆传送到地下城一层");
        public static var FINISH_SWITCHMAP_LOADING_YongZheDaLu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(52, "传送loading成功 - 从勇者大陆传送到地下城一层");
        public static var CLICK_SWITCHMAP_BingFengGu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(53, "立即传送 - 从冰风谷传送到地下城二层");
        public static var FINISH_SWITCHMAP_BingFengGu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(54, "传送成功 - 从冰风谷传送到地下城二层");
        public static var FINISH_SWITCHMAP_LOADING_BingFengGu_to_DiXiaCheng:ClickStreamId = new ClickStreamId(55, "传送loading成功 - 从冰风谷传送到地下城二层");
        public static var CLICK_XueSeChengBao_ZuDuiJinRu:ClickStreamId = new ClickStreamId(56, "血色城堡 - 点击组队进入");
        public static var CLICK_XueSeChengBao_DanRenJinRu:ClickStreamId = new ClickStreamId(57, "血色城堡 - 点击单人进入");
        public static var FINISH_SWITCHMAP_XueSeChengBao:ClickStreamId = new ClickStreamId(58, "血色城堡 - 进入成功");
        public static var FINISH_SWITCHMAP_LOADING_XueSeChengBao:ClickStreamId = new ClickStreamId(59, "血色城堡 - 进入loading成功");
        public static var AUTO_REGIST_WHEN_NO_OPERATION:ClickStreamId = new ClickStreamId(60, "进入游戏 - 30秒自动创角");

        public function ClickStreamId(param1:uint, param2:String)
        {
            this.id = param1;
            this.name = param2;
            return;
        }// end function

        public function get fullName() : String
        {
            return this.id + "." + this.name;
        }// end function

    }
}
