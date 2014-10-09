package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.utils.*;
    import com.model.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.text.*;

    public class ChatInfo extends Object
    {
        private var _chattype:int;
        private var _chater:long;
        private var _chatername:String;
        private var _chaterlevel:int;
        private var _chaterkinglv:int;
        private var _country:int;
        private var _viptype:int;
        private var _receiver:long;
        private var _receiverlevel:int;
        private var _receivername:String;
        private var _receiverviptype:int;
        private var _condition:String;
        private var _other:Vector.<ChatGoodInfo>;
        private var _isgm:int;
        private var _webvip:int;
        private var _receiverwebvip:int;
        private var _vipLevel:int;
        private var _txt:String;
        private var _src:Array;
        private var _label:String;
        private var _faceArr:Array;
        private var _itemArr:Array;
        public static const FACELENGTH:int = 21;

        public function ChatInfo()
        {
            this._other = new Vector.<ChatGoodInfo>;
            return;
        }// end function

        public function get vipLevel() : int
        {
            return this._vipLevel;
        }// end function

        public function set vipLevel(param1:int) : void
        {
            this._vipLevel = param1;
            return;
        }// end function

        public function get isgm() : int
        {
            return this._isgm;
        }// end function

        public function set isgm(param1:int) : void
        {
            this._isgm = param1;
            return;
        }// end function

        public function get isGM_() : int
        {
            return this._isgm & 1;
        }// end function

        public function get isInstructor() : int
        {
            return this._isgm & 2;
        }// end function

        public function get faceArr() : Array
        {
            return this._faceArr;
        }// end function

        public function set faceArr(param1:Array) : void
        {
            this._faceArr = param1;
            return;
        }// end function

        public function get itemArr() : Array
        {
            return this._itemArr;
        }// end function

        public function set itemArr(param1:Array) : void
        {
            this._itemArr = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            return;
        }// end function

        public function get src() : Array
        {
            return this._src;
        }// end function

        public function set src(param1:Array) : void
        {
            this._src = param1;
            return;
        }// end function

        public function get txt() : String
        {
            return this._txt;
        }// end function

        public function set txt(param1:String) : void
        {
            this._txt = param1;
            return;
        }// end function

        public function get other() : Vector.<ChatGoodInfo>
        {
            return this._other;
        }// end function

        public function set other(param1:Vector.<ChatGoodInfo>) : void
        {
            this._other = param1;
            return;
        }// end function

        public function set data(param1:Vector.<GoodsInfoRes>) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 && param1.length)
            {
                _loc_2 = param1.length;
                this._other = new Vector.<ChatGoodInfo>;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this._other[_loc_3] = new ChatGoodInfo(param1[_loc_3]);
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function get condition() : String
        {
            return this._condition;
        }// end function

        public function set condition(param1:String) : void
        {
            this._condition = param1;
            return;
        }// end function

        public function get receiverviptype() : int
        {
            return this._receiverviptype;
        }// end function

        public function set receiverviptype(param1:int) : void
        {
            this._receiverviptype = param1;
            return;
        }// end function

        public function get receivername() : String
        {
            return this._receivername;
        }// end function

        public function set receivername(param1:String) : void
        {
            this._receivername = param1;
            return;
        }// end function

        public function get receiverlevel() : int
        {
            return this._receiverlevel;
        }// end function

        public function set receiverlevel(param1:int) : void
        {
            this._receiverlevel = param1;
            return;
        }// end function

        public function get receiver() : long
        {
            return this._receiver;
        }// end function

        public function set receiver(param1:long) : void
        {
            this._receiver = param1;
            return;
        }// end function

        public function get viptype() : int
        {
            return this._viptype;
        }// end function

        public function set viptype(param1:int) : void
        {
            this._viptype = param1;
            return;
        }// end function

        public function get country() : int
        {
            return this._country;
        }// end function

        public function set country(param1:int) : void
        {
            this._country = param1;
            return;
        }// end function

        public function get chaterkinglv() : int
        {
            return this._chaterkinglv;
        }// end function

        public function set chaterkinglv(param1:int) : void
        {
            this._chaterkinglv = param1;
            return;
        }// end function

        public function get chaterlevel() : int
        {
            return this._chaterlevel;
        }// end function

        public function set chaterlevel(param1:int) : void
        {
            this._chaterlevel = param1;
            return;
        }// end function

        public function get chatername() : String
        {
            return this._chatername;
        }// end function

        public function set chatername(param1:String) : void
        {
            this._chatername = param1;
            return;
        }// end function

        public function get chater() : long
        {
            return this._chater;
        }// end function

        public function set chater(param1:long) : void
        {
            this._chater = param1;
            return;
        }// end function

        public function get chattype() : int
        {
            return this._chattype;
        }// end function

        public function set chattype(param1:int) : void
        {
            this._chattype = param1;
            return;
        }// end function

        public function toString() : String
        {
            return this._condition;
        }// end function

        private function getTextformat(param1:int) : uint
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case ChatType.CHATTYPE_WORLD:
                {
                    _loc_2 = ChatType.COLOR_WORLD;
                    break;
                }
                case ChatType.CHATTYPE_SCENE:
                {
                    _loc_2 = ChatType.COLOR_SCENE;
                    break;
                }
                case ChatType.CHATTYPE_ROLE:
                {
                    _loc_2 = ChatType.COLOR_ROLE;
                    break;
                }
                case ChatType.CHATTYPE_TEAM:
                {
                    _loc_2 = ChatType.COLOR_TEAM;
                    break;
                }
                case ChatType.CHATTYPE_GROUP:
                {
                    _loc_2 = ChatType.COLOR_GROUP;
                    break;
                }
                case ChatType.CHATTYPE_HORN:
                {
                    _loc_2 = ChatType.COLOR_HORN;
                    break;
                }
                case ChatType.CHATTYPE_SYSTEM:
                {
                    _loc_2 = ChatType.COLOR_SYSTEM;
                    break;
                }
                case ChatType.CHATTYPE_TRANSACTION:
                {
                    _loc_2 = ChatType.COLOR_TRANSACTION;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function clone() : ChatInfo
        {
            var _loc_1:* = new ChatInfo();
            _loc_1.chater = this.chater;
            _loc_1.chaterkinglv = this.chaterkinglv;
            _loc_1.chaterlevel = this.chaterlevel;
            _loc_1.chatername = this.chatername;
            _loc_1.chattype = this.chattype;
            _loc_1.condition = this.condition;
            _loc_1.country = this.country;
            _loc_1.other = this.other;
            _loc_1.receiver = this.receiver;
            _loc_1.receiverlevel = this.receiverlevel;
            _loc_1.receivername = this.receivername;
            _loc_1.receiverviptype = this.receiverviptype;
            _loc_1.viptype = this.viptype;
            _loc_1.vipLevel = this.vipLevel;
            _loc_1.isgm = this.isgm;
            _loc_1.parse();
            return _loc_1;
        }// end function

        public function parse(param1:Boolean = true) : void
        {
            var _loc_7:* = false;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            this._faceArr = [];
            var _loc_2:* = "";
            this._webvip = 1;
            if (param1)
            {
                if (this._chattype == ChatType.CHATTYPE_ROLE)
                {
                    if (this._chater)
                    {
                        if (this._chatername == UserObj.getInstance().playerInfo.name)
                        {
                            _loc_2 = _loc_2 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11776"), [this._receivername, this._receiver]);
                        }
                        else
                        {
                            _loc_2 = _loc_2 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11777"), [this._chatername, this._chater]);
                        }
                    }
                }
                else if (this._chattype == ChatType.CHATTYPE_GM)
                {
                    _loc_2 = _loc_2 + ("<font color= \'#21ff00\'>" + LanguageCfgObj.getInstance().getByIndex("11778") + "</font>：");
                }
                else if (this._chattype == ChatType.CHATTYPE_SYSTEM)
                {
                }
                else if (this._chater && this.chattype != ChatType.CHATTYPE_HORN)
                {
                    if (this._chatername != UserObj.getInstance().playerInfo.name)
                    {
                        _loc_2 = _loc_2 + ("<u><font color = \'#ffde00\'><a href=\'event:user|" + this._chatername + "|" + this._chater + "\'>" + this.chatername + "</a></font></u>：");
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#ffde00\'>" + LanguageCfgObj.getInstance().getByIndex("11779") + "</font>：");
                    }
                }
                if (this.chattype != ChatType.CHATTYPE_HORN)
                {
                    this._faceArr.push({src:"chat_channel_" + this.chattype, index:0});
                    if (this.isGM_)
                    {
                        this._faceArr.push({src:ChatCfg.GM_RES_NAME, index:0.1});
                    }
                    if (this.isInstructor)
                    {
                        this._faceArr.push({src:ChatCfg.INSTRUCTOR_RES_NAME, index:0.2});
                    }
                    if (this._viptype != VipType.NORMAL && this._viptype < VipType.TOP_LEVEL)
                    {
                        this._faceArr.push({src:"vip_high_" + this._vipLevel, index:0.3});
                    }
                    else if (this._viptype == VipType.TOP_LEVEL)
                    {
                        this._faceArr.push({src:"vip_top_level_" + this.vipLevel, index:0.3});
                    }
                }
                _loc_2 = _loc_2 + "<font color = \'#" + this.getTextformat(this._chattype).toString(16) + "\'>" + this.condition + "</font>";
            }
            else
            {
                _loc_2 = _loc_2 + this.condition;
            }
            var _loc_3:* = 0;
            var _loc_4:* = new TextField();
            _loc_4.htmlText = _loc_2;
            var _loc_5:* = _loc_4.text;
            var _loc_6:* = _loc_5.length;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            while (_loc_9 < _loc_6)
            {
                
                _loc_10 = _loc_5.charAt(_loc_9);
                if (_loc_10 == "#" && _loc_8 < 3)
                {
                    _loc_11 = _loc_5.substr((_loc_9 + 1), 2);
                    _loc_12 = int(_loc_11);
                    if (_loc_12 > 0 && _loc_12 <= FACELENGTH)
                    {
                        if (_loc_12.toString().length < 2)
                        {
                            _loc_11 = ToolKit.add0(_loc_12, 2);
                            if (_loc_12 == int(_loc_11.charAt(0)))
                            {
                                _loc_9 = _loc_9 + 1;
                            }
                            else
                            {
                                _loc_9 = _loc_9 + 2;
                            }
                        }
                        else
                        {
                            _loc_9 = _loc_9 + 2;
                        }
                        _loc_8++;
                        if (this._viptype != 0)
                        {
                            this._faceArr.push({src:"#" + _loc_11, index:_loc_3});
                        }
                        ;
                    }
                    else
                    {
                        _loc_11 = _loc_5.substr((_loc_9 + 1), 1);
                        _loc_12 = int(_loc_11);
                        if (_loc_12 > 0 && _loc_12 <= ChatInfo.FACELENGTH)
                        {
                            _loc_11 = ToolKit.add0(_loc_12, 2);
                            _loc_9 = _loc_9 + 1;
                            _loc_8++;
                            if (this._viptype != 0)
                            {
                                this._faceArr.push({src:"#" + _loc_11, index:_loc_3});
                            }
                        }
                    }
                }
                else if (_loc_10 == "\f")
                {
                    this._faceArr.push({src:"chatlinkItem", index:_loc_3});
                }
                _loc_3++;
                _loc_9++;
            }
            this.txt = RichTxtUtil.makeTxt(_loc_2);
            return;
        }// end function

    }
}
