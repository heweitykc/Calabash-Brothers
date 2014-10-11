package com.game.chat.utils
{
    import com.cfg.*;
    import com.f1.utils.*;
    import com.game.chat.view.*;
    import com.game.vip.view.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class ChatUtil extends Object
    {

        public function ChatUtil()
        {
            return;
        }// end function

        public static function makeSrc(param1:ChatInfo) : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = [];
            if (param1.faceArr.length > 0)
            {
                _loc_3 = 0;
                _loc_4 = 0;
                while (_loc_4 < param1.faceArr.length)
                {
                    
                    _loc_5 = param1.faceArr[_loc_4].src;
                    if (_loc_5.charAt(0) == "#")
                    {
                        _loc_6 = int(_loc_5.substr(1));
                        param1.faceArr[_loc_4].src = ToolKit.getNew("face_" + ToolKit.add0(_loc_6, 2));
                        _loc_2.push({src:param1.faceArr[_loc_4].src, index:param1.faceArr[_loc_4].index});
                    }
                    else if (_loc_5 == "chatlinkItem")
                    {
                        _loc_7 = new ChatLinkItem();
                        _loc_7.info = param1.other[_loc_3].propInfo;
                        _loc_3++;
                        _loc_2.push({src:_loc_7, index:param1.faceArr[_loc_4].index});
                    }
                    else if (_loc_5.slice(0, 3) == "vip")
                    {
                        _loc_8 = new VIPChatIcon();
                        _loc_8.src = _loc_5;
                        _loc_2.push({src:_loc_8, index:param1.faceArr[_loc_4].index});
                    }
                    else if (_loc_5 == "horn_icon")
                    {
                        _loc_9 = new ChatButton(ToolKit.getNew("horn_icon"));
                        _loc_2.push({src:_loc_9, index:param1.faceArr[_loc_4].index});
                    }
                    else if (_loc_5 == ChatCfg.GM_RES_NAME)
                    {
                        param1.faceArr[_loc_4].src = getDefinitionByName(ChatCfg.GM_RES_NAME);
                        _loc_2.push({src:param1.faceArr[_loc_4].src, index:param1.faceArr[_loc_4].index});
                    }
                    else if (_loc_5 == ChatCfg.INSTRUCTOR_RES_NAME)
                    {
                        param1.faceArr[_loc_4].src = getDefinitionByName(ChatCfg.INSTRUCTOR_RES_NAME);
                        _loc_2.push({src:param1.faceArr[_loc_4].src, index:param1.faceArr[_loc_4].index});
                    }
                    else
                    {
                        _loc_2.push({src:param1.faceArr[_loc_4].src, index:param1.faceArr[_loc_4].index});
                    }
                    _loc_4++;
                }
            }
            return _loc_2;
        }// end function

        public static function makeTxt(param1:String) : void
        {
            return;
        }// end function

    }
}
