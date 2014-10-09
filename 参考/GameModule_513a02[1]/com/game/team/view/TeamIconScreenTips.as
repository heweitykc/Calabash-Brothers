package com.game.team.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.team.bean.*;
    import com.game.team.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class TeamIconScreenTips extends BaseTips
    {
        private var _backBmp:Sprite;
        private var _content:Sprite;
        private var _txtInfo:TextField;
        private var _txtLeftCount:TextField;

        public function TeamIconScreenTips()
        {
            this.initTips();
            return;
        }// end function

        private function initTips() : void
        {
            this._backBmp = ToolKit.getNew("generalHoverWndBg");
            this._backBmp.width = 265;
            addChild(this._backBmp);
            this._content = new Sprite();
            this._content.x = 13;
            this._content.y = 15;
            addChild(this._content);
            this._txtInfo = new TextField();
            this._txtInfo.width = 240;
            this._txtInfo.multiline = true;
            this._txtInfo.wordWrap = true;
            this._content.addChild(this._txtInfo);
            this._txtLeftCount = new TextField();
            this._txtLeftCount.width = 225;
            this._txtInfo.height = 32;
            this._content.addChild(this._txtLeftCount);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_8:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = TeamModel.getInstance().vecTeamInfo;
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = LanguageCfgObj.getInstance().getByIndex("11347");
            var _loc_6:* = "<font color = \'#FF9900\' size = \'14\'>" + LanguageCfgObj.getInstance().getByIndex("12255") + " " + _loc_4 + " </font><br>";
            var _loc_7:* = "";
            var _loc_9:* = 0;
            while (_loc_9 < _loc_4)
            {
                
                _loc_8 = _loc_3[_loc_9];
                _loc_7 = _loc_7 + ("     " + LanguageCfgObj.getInstance().getByIndex("12256") + _loc_5.charAt(_loc_9) + LanguageCfgObj.getInstance().getByIndex("12257") + "  " + _loc_8.membername + (_loc_8.isonline == 0 ? ("<font color = \'#ff0000\'>     [" + LanguageCfgObj.getInstance().getByIndex("12258") + "]</font>") : ("")) + "<br>");
                if (_loc_8.isonline == 0)
                {
                    _loc_2++;
                }
                _loc_9++;
            }
            _loc_6 = _loc_6 + ("<textformat leading = \'7\'><font color = \'#FFD47F\'>" + _loc_7 + "</font></textformat>");
            _loc_6 = _loc_6 + ("<font color = \'#FF9900\' size = \'14\'>" + LanguageCfgObj.getInstance().getByIndex("12259") + "</font><br>");
            _loc_10 = --_loc_4 < 0 ? (0) : (--_loc_4);
            _loc_10 = _loc_10 * 10;
            _loc_6 = _loc_6 + ("<font color = \'#00cc00\'>      " + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12260"), [_loc_10]) + "</font>");
            _loc_6 = "<textformat leading = \'12\'>" + _loc_6 + "</textformat>";
            this._txtInfo.htmlText = _loc_6;
            this._txtInfo.height = this._txtInfo.textHeight + 15;
            this._backBmp.height = this._txtInfo.textHeight + 35;
            this._txtLeftCount.htmlText = "<p align = \'right\'><font color = \'#FF9900\' size = \'14\'>" + LanguageCfgObj.getInstance().getByIndex("12261") + _loc_2 + "</font></p>";
            return;
        }// end function

    }
}
