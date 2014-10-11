package com.game.magicbook.model
{
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.game.magicbook.message.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.player.message.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;

    public class MagicBookData extends BaseEventDispatcher
    {
        public static const BREAK_SUCCESS:String = "breakSuccess";
        public static const ONEKEY_UP_EXP:String = "onekeyUpExp";
        public static const STOP_ONEKEY:String = "stopOnekey";
        public static const STATE_CHANGE:String = "stateChange";
        public static var isOpenGrowFunction:Boolean = false;
        public static var state:int;
        private static var _info:MagicBookInfo;
        private static var _otherInfo:MagicBookInfo;

        public function MagicBookData()
        {
            return;
        }// end function

        public static function getMagicBookInfo() : MagicBookInfo
        {
            if (!_info)
            {
                _info = new MagicBookInfo();
            }
            return _info;
        }// end function

        public static function parse(param1:ResMyPlayerInfoMessage) : void
        {
            getMagicBookInfo().level = param1.magicBookLevel;
            return;
        }// end function

        public static function getOtherMagicInfo() : MagicBookInfo
        {
            if (!_otherInfo)
            {
                _otherInfo = new MagicBookInfo();
            }
            return _otherInfo;
        }// end function

        public static function saveOtherMagicBookInfo(param1:ResSeeOtherMagicbookMessage) : void
        {
            getOtherMagicInfo().level = param1.level;
            getOtherMagicInfo().skills_m = param1.skills;
            getOtherMagicInfo().potential = param1.potential;
            getOtherMagicInfo().setMagicAttrInfos(param1.attrs);
            getOtherMagicInfo().dispatchEvent(new MagicBookEvent(MagicBookEvent.UPDATE_OTHER_INFO));
            return;
        }// end function

        public static function isShowIcon() : Boolean
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            var _loc_2:* = TopActivateCfgObj.getInstance().getButtonShowLevel(TopActivateName.TOP_ICON_MAGIC_BOOK);
            if (_loc_1 >= _loc_2)
            {
                if (UserObj.getInstance().playerInfo.magicBook)
                {
                    return false;
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public static function canOpenPanel() : Boolean
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            var _loc_2:* = TopActivateCfgObj.getInstance().getButtonShowLevel(TopActivateName.TOP_ICON_MAGIC_BOOK);
            if (_loc_1 >= _loc_2)
            {
                return true;
            }
            return false;
        }// end function

        public static function hasOpenMagicBook() : Boolean
        {
            if (_info)
            {
                return _info.level > 0;
            }
            return false;
        }// end function

        public static function addEventListener(param1:String, param2:Function) : void
        {
            getMagicBookInfo().addEvtListener(param1, param2);
            return;
        }// end function

        public static function removeEventListener(param1:String, param2:Function) : void
        {
            getMagicBookInfo().removeEvtListener(param1, param2);
            return;
        }// end function

        public static function dispatchEvent(event:Event) : void
        {
            getMagicBookInfo().dispatchEvt(event);
            return;
        }// end function

    }
}
