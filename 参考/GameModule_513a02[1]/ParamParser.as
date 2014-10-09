package 
{
    import com.*;
    import com.f1.*;
    import com.game.clickstream.*;
    import com.staticdata.*;

    public class ParamParser extends Object
    {

        public function ParamParser()
        {
            return;
        }// end function

        public static function parse() : void
        {
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_1:* = FrameworkGlobal.flashvars;
            var _loc_2:* = _loc_1.uuin;
            var _loc_3:* = _loc_1["opengm"];
            if (_loc_3 != null && _loc_3.length > 0)
            {
                if (_loc_3 == "1")
                {
                    Params.opengm = true;
                }
            }
            var _loc_4:* = _loc_1["real_user"];
            if (_loc_1["real_user"] != null && _loc_4.length > 0)
            {
                if (_loc_4 == "2")
                {
                    Params.needPlatReg = true;
                }
            }
            var _loc_5:* = _loc_1["user_name"];
            if (_loc_1["user_name"] != null && _loc_5.length > 0)
            {
                Params.username = _loc_5;
            }
            var _loc_6:* = _loc_1["adulturl"];
            if (_loc_1["adulturl"] != null && _loc_6.length > 0)
            {
                Params.adulturl = _loc_6;
            }
            var _loc_7:* = _loc_1["is_adult"];
            if (_loc_1["is_adult"] != null && _loc_7.length > 0)
            {
                Params.isadult = _loc_7;
            }
            var _loc_8:* = _loc_1["sign"];
            if (_loc_1["sign"] != null && _loc_8.length > 0)
            {
                Params.pfMD5Key = _loc_8;
                Params.isPlatform = true;
            }
            else
            {
                Params.isPlatform = false;
            }
            var _loc_9:* = _loc_1["server_id"];
            if (_loc_1["server_id"] != null && _loc_9.length > 0)
            {
                Params.serverid = _loc_9;
            }
            var _loc_10:* = _loc_1["server_outer_id"];
            if (_loc_1["server_outer_id"] != null && _loc_10.length > 0)
            {
                Params.serverOuterId = _loc_10;
            }
            var _loc_11:* = _loc_1["time"];
            if (_loc_1["time"] != null && _loc_11.length > 0)
            {
                Params.time = _loc_11;
            }
            var _loc_12:* = _loc_1["logintype"];
            if (_loc_1["logintype"] != null && _loc_12.length > 0)
            {
                Params.loginType = _loc_12;
            }
            var _loc_13:* = _loc_1["pvType"];
            if (_loc_1["pvType"] != null && _loc_13.length > 0)
            {
                Params.pvType = _loc_13;
            }
            var _loc_14:* = _loc_1["pvPage"];
            if (_loc_1["pvPage"] != null && _loc_14.length > 0)
            {
                Params.pvPage = _loc_14;
            }
            var _loc_15:* = _loc_1["wdEnabled"];
            if (_loc_1["wdEnabled"] != null && _loc_15.length > 0)
            {
                Params.wdType = _loc_15;
            }
            var _loc_16:* = _loc_1["wdDownloadUrl"];
            if (_loc_1["wdDownloadUrl"] != null && _loc_16.length > 0)
            {
                Params.wdUrl = _loc_16;
            }
            var _loc_17:* = _loc_1["autoLogin"];
            if (_loc_1["autoLogin"] == "1")
            {
                Params.autoLogin = true;
            }
            var _loc_18:* = _loc_1["autoFight"];
            if (_loc_1["autoFight"] == "1")
            {
                Params.autoFight = true;
            }
            var _loc_19:* = _loc_1["officialWebSite"];
            if (_loc_1["officialWebSite"] != null && _loc_19.length > 0)
            {
                Params.officialWebSite = _loc_19;
            }
            var _loc_20:* = _loc_1["rechargePage"];
            if (_loc_1["rechargePage"] != null && _loc_20.length > 0)
            {
                Params.rechargePage = _loc_20;
            }
            var _loc_21:* = _loc_1["pf"];
            if (_loc_1["pf"] != null && _loc_21.length > 0)
            {
                Params.pf = _loc_21;
            }
            var _loc_22:* = _loc_1["port"];
            if (_loc_1["port"] != null && _loc_22.length > 0 && !isNaN(Number(_loc_22)))
            {
                Params.PORT = uint(_loc_22);
            }
            var _loc_23:* = _loc_1["ip"];
            if (_loc_1["ip"] != null && _loc_23.length > 0)
            {
                Params.IP = _loc_23;
            }
            var _loc_24:* = _loc_1["sport"];
            if (_loc_1["sport"] != null && _loc_24.length > 0)
            {
                Params.SPORT = uint(_loc_24);
            }
            var _loc_25:* = _loc_1["actip"];
            if (_loc_1["actip"] != null && _loc_25.length > 0)
            {
                Params.pfActSvrIp = _loc_25;
            }
            var _loc_26:* = _loc_1["actport"];
            if (_loc_1["actport"] != null && _loc_26.length > 0)
            {
                Params.pfActSvrPort = uint(_loc_26);
            }
            var _loc_27:* = _loc_1["openid"];
            if (_loc_1["openid"] != null && _loc_27.length > 0)
            {
                BasicGlobal.openid = _loc_27;
            }
            var _loc_28:* = _loc_1["openkey"];
            if (_loc_1["openkey"] != null && _loc_28.length > 0)
            {
                Params.openkey = _loc_28;
            }
            var _loc_29:* = _loc_1["pfkey"];
            if (_loc_21 != null && _loc_21.length > 0)
            {
                Params.pfkey = _loc_29;
            }
            var _loc_30:* = _loc_1["via"];
            if (_loc_1["via"] != null && _loc_30.length > 0)
            {
                Params.via = _loc_30;
            }
            var _loc_31:* = _loc_1["zoneid"];
            if (_loc_1["zoneid"] != null && _loc_31.length > 0)
            {
                Params.zoneid = uint(_loc_31);
            }
            var _loc_32:* = _loc_1["app_user_source"];
            if (_loc_1["app_user_source"] != null && _loc_32.length > 0)
            {
                Params.task_market_source = _loc_32;
            }
            var _loc_33:* = _loc_1["app_contract_id"];
            if (_loc_1["app_contract_id"] != null && _loc_33.length > 0)
            {
                Params.task_market_contract_id = _loc_33;
            }
            var _loc_34:* = _loc_1["app_custom"];
            if (_loc_1["app_custom"] != null && _loc_34.length > 0)
            {
                Params.task_market_custom_id = _loc_34;
            }
            var _loc_35:* = _loc_1["clickStream"];
            if (_loc_1["clickStream"] != null && _loc_35.length > 0)
            {
                ClickStream.host = _loc_35;
            }
            var _loc_36:* = _loc_1["clickStreamOn"];
            if (_loc_1["clickStreamOn"] == "0")
            {
                Params.clickStreamOn = false;
            }
            var _loc_37:* = _loc_1["login"];
            if (_loc_1["login"] != null && _loc_37.length > 0)
            {
                Params.loginBinURL = _loc_37;
            }
            var _loc_38:* = _loc_1["registSceneSwf"];
            if (_loc_1["registSceneSwf"] != null && _loc_38.length > 0)
            {
                Params.registSceneSwfURL = _loc_38;
            }
            if (Params.pf1360())
            {
                _loc_45 = _loc_1["qid"];
                if (_loc_45 != null && _loc_45.length > 0)
                {
                    BasicGlobal.openid = _loc_45;
                }
            }
            else if (Params.pfTencent())
            {
                _loc_46 = _loc_1["iopenid"];
                if (_loc_46 != null && _loc_46.length > 0)
                {
                    Params.invitorOpenID = _loc_46;
                }
            }
            var _loc_39:* = _loc_1["filesXML"];
            if (_loc_1["filesXML"] != null && _loc_39.length > 0)
            {
                Params.files_XML_path = _loc_39;
            }
            var _loc_40:* = _loc_1["rechargePage"];
            if (_loc_1["rechargePage"] != null && _loc_40.length > 0)
            {
                Params.officialRechargeWebSite = _loc_40;
            }
            var _loc_41:* = _loc_1["cardUrl"];
            if (_loc_1["cardUrl"] != null && _loc_41.length > 0)
            {
                Params.getCardWebSite = _loc_41;
            }
            var _loc_42:* = _loc_1["language"];
            if (_loc_1["language"] != null && _loc_42.length > 0)
            {
                FrameworkGlobal.language = _loc_42;
            }
            var _loc_43:* = _loc_1["facebook_uid"];
            if (_loc_1["facebook_uid"] != null && _loc_43.length > 0)
            {
                Params.facebookUserId = _loc_43;
            }
            var _loc_44:* = _loc_1["facebook_uname"];
            if (_loc_1["facebook_uname"] != null && _loc_44.length > 0)
            {
                Params.facebookUserName = _loc_44;
            }
            return;
        }// end function

    }
}
