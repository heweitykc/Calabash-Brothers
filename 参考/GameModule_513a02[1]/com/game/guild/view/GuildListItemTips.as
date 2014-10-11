package com.game.guild.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class GuildListItemTips extends BaseTips
    {
        private var _backBmp:Sprite;
        private var _txtGuildName:TextField;
        private var _txtBangZhuName:TextField;
        private var _txtViceBangZhuName:TextField;
        private var _txtCreateTime:TextField;
        private var _txtCreateTimeDes:TextField;
        private var _content:Sprite;

        public function GuildListItemTips()
        {
            this._backBmp = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backBmp);
            this._content = new Sprite();
            this._content.x = 10;
            this._content.y = 10;
            addChild(this._content);
            this._txtGuildName = new TextField();
            this._txtGuildName.width = 200;
            this._txtGuildName.height = 20;
            this._content.addChild(this._txtGuildName);
            this._txtBangZhuName = new TextField();
            this._txtBangZhuName.width = 300;
            this._txtBangZhuName.height = 20;
            this._txtBangZhuName.x = 20;
            this._txtBangZhuName.y = this._txtGuildName.y + this._txtGuildName.height + 5;
            this._content.addChild(this._txtBangZhuName);
            this._txtViceBangZhuName = new TextField();
            this._txtViceBangZhuName.width = 300;
            this._txtViceBangZhuName.height = 20;
            this._txtViceBangZhuName.x = 20;
            this._txtViceBangZhuName.y = this._txtBangZhuName.y + this._txtBangZhuName.height + 2;
            this._content.addChild(this._txtViceBangZhuName);
            this._txtCreateTime = new TextField();
            this._txtCreateTime.width = 100;
            this._txtCreateTime.height = 20;
            this._txtCreateTime.y = this._txtViceBangZhuName.y + this._txtViceBangZhuName.height + 5;
            this._txtCreateTime.textColor = 16766079;
            this._txtCreateTime.text = LanguageCfgObj.getInstance().getByIndex("10832");
            this._content.addChild(this._txtCreateTime);
            this._txtCreateTimeDes = new TextField();
            this._txtCreateTimeDes.width = 200;
            this._txtCreateTimeDes.height = 20;
            this._txtCreateTimeDes.x = 20;
            this._txtCreateTimeDes.y = this._txtCreateTime.y + this._txtCreateTime.height + 5;
            this._content.addChild(this._txtCreateTimeDes);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            if (param1 == null)
            {
                return;
            }
            this._txtGuildName.htmlText = "<font color = \'#ffd47f\' size = \'12\'>" + LanguageCfgObj.getInstance().getByIndex("12074") + param1.guildName + "</font>";
            this._txtBangZhuName.htmlText = "<font color = \'#ffd47f\' size = \'12\'>" + LanguageCfgObj.getInstance().getByIndex("12077") + "</font><font color=\'#A96C4E\'>" + param1.bangZhuName + "</font><font color = \'#ffd47f\' size = \'12\'>  " + LanguageCfgObj.getInstance().getByIndex("12079") + "</font><font color=\'#A96C4E\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [param1.bangZhuLevel]) + "</font> " + (param1.bangZhuOnline ? ("<font color=\'#18F145\'>[" + LanguageCfgObj.getInstance().getByIndex("12075") + "]</font>") : ("<font color=\'#ED2C0E\'>[" + LanguageCfgObj.getInstance().getByIndex("12076") + "]</font>")) + "</font>";
            if (param1.viceBangZhuName)
            {
                this._txtViceBangZhuName.htmlText = "<font color = \'#ffd47f\' size = \'12\'>" + LanguageCfgObj.getInstance().getByIndex("12078") + "</font><font color=\'#A96C4E\'>" + param1.viceBangZhuName + "</font><font color = \'#ffd47f\' size = \'12\'>  " + LanguageCfgObj.getInstance().getByIndex("12079") + "</font><font color=\'#A96C4E\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [param1.viceBangZhuLevel]) + "</font> " + (param1.viceBangZhuOnline ? ("<font color=\'#18F145\'>[" + LanguageCfgObj.getInstance().getByIndex("12075") + "]</font>") : ("<font color=\'#ED2C0E\'>[" + LanguageCfgObj.getInstance().getByIndex("12076") + "]</font>")) + "</font>";
            }
            else
            {
                this._txtViceBangZhuName.htmlText = "";
            }
            this._txtCreateTimeDes.htmlText = "<font color = \'#A96C4E\' size = \'12\'>" + ToolKit.parseSecond2Date(param1.createTime) + "</font>";
            this._backBmp.height = this._content.height + 20;
            this._backBmp.width = this._content.width + 20;
            return;
        }// end function

    }
}
