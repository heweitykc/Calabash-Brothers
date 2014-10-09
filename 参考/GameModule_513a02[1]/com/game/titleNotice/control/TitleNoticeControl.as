package com.game.titleNotice.control
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.titleNotice.view.*;

    public class TitleNoticeControl extends Object
    {
        private var _msgQueue:Array;
        private var _icon:TitleNoticeIcon;
        private static var _instacne:TitleNoticeControl;
        public static const MAX_MSG:int = 5;

        public function TitleNoticeControl()
        {
            this._msgQueue = [];
            return;
        }// end function

        public function showIcon() : void
        {
            if (this._icon == null)
            {
                this._icon = new TitleNoticeIcon();
            }
            Global.popManager.addedServerToCue(this._icon);
            return;
        }// end function

        public function hideIcon() : void
        {
            Global.popManager.removeServerToCue(this._icon);
            return;
        }// end function

        public function addMsg(param1:int, param2:int, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            if (param1)
            {
                _loc_7 = TitleCfgObj.getInstance().getTitleById(param1);
            }
            var _loc_4:* = _loc_7.q_get_type / 10;
            var _loc_6:* = ToolKit.getTimeBySecond2(param3);
            if (param2 == 0)
            {
                _loc_5 = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12361"), _loc_6, _loc_7.q_titlename);
            }
            else
            {
                switch(_loc_4)
                {
                    case 3:
                    {
                        _loc_5 = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12362"), _loc_6, LanguageCfgObj.getInstance().getByIndex("TitleNoticeControl_12424"), _loc_7.q_titlename);
                        break;
                    }
                    default:
                    {
                        _loc_5 = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12363"), _loc_6, LanguageCfgObj.getInstance().getByIndex("TitleNoticeControl_12425"), _loc_7.q_titlename);
                        break;
                        break;
                    }
                }
            }
            this._msgQueue.unshift(_loc_5);
            if (MAX_MSG < this._msgQueue.length)
            {
                this._msgQueue.pop();
            }
            this.showIcon();
            this._icon.titleId = param1;
            return;
        }// end function

        public function get msgToString() : String
        {
            return this._msgQueue.join("");
        }// end function

        public static function get instance() : TitleNoticeControl
        {
            if (_instacne == null)
            {
                _instacne = new TitleNoticeControl;
            }
            return _instacne;
        }// end function

    }
}
