package com.game.chat.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.guild.chat.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ChatInput extends TextField
    {
        private var _indexs:Array;
        private var _goods:Array;
        private var template:String;
        private var _strlength:int;
        private var _st:Stage;
        private var html:String;
        private var _horn:HornPanel;
        private var _faceCount:int;
        private const MAX_FACE_COUNT:int = 3;
        private var _format:TextFormat;
        public var isMultine:Boolean;
        private var preChangeLength:int;
        private var _guildChat:GuildChatBox;
        private var _isDefault:Boolean;
        private static const MAX_WORD:int = 100;

        public function ChatInput()
        {
            this.template = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11678"), [PropUtil.GRAY.toString(16)]);
            this._indexs = [];
            this._goods = [];
            type = "input";
            width = 150;
            height = 22;
            maxChars = MAX_WORD;
            this._format = defaultTextFormat;
            this._format.font = "SimSun";
            this._format.color = 16771767;
            defaultTextFormat = this._format;
            multiline = false;
            addEventListener(TextEvent.TEXT_INPUT, this.__input, false, 0, true);
            addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
            addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            addEventListener(FocusEvent.FOCUS_OUT, this.__focusOut, false, 0, true);
            htmlText = this.template;
            this.clear();
            this._st = FrameworkGlobal.stage;
            return;
        }// end function

        public function get guildChat() : GuildChatBox
        {
            return this._guildChat;
        }// end function

        public function set guildChat(param1:GuildChatBox) : void
        {
            this._guildChat = param1;
            return;
        }// end function

        public function get horn() : HornPanel
        {
            return this._horn;
        }// end function

        public function set horn(param1:HornPanel) : void
        {
            this._horn = param1;
            return;
        }// end function

        private function __focusOut(event:FocusEvent) : void
        {
            return;
        }// end function

        public function get strlength() : int
        {
            return this._strlength;
        }// end function

        public function set strlength(param1:int) : void
        {
            this._strlength = param1;
            return;
        }// end function

        public function get isDefault() : Boolean
        {
            return this._isDefault;
        }// end function

        public function set isDefault(param1:Boolean) : void
        {
            this._isDefault = param1;
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            if (this._isDefault)
            {
                text = "";
                this._isDefault = false;
            }
            return;
        }// end function

        private function __input(event:TextEvent) : void
        {
            var _loc_4:* = 0;
            if (this._isDefault)
            {
                this._isDefault = false;
                htmlText = "";
            }
            var _loc_2:* = this.checkIndex();
            var _loc_3:* = _loc_2[0];
            if (_loc_3 > -1)
            {
                event.preventDefault();
            }
            else
            {
                _loc_4 = _loc_2[1];
                while (_loc_4 < this._indexs.length)
                {
                    
                    this._indexs[_loc_4][0] = this._indexs[_loc_4][0] + event.text.length;
                    this._indexs[_loc_4][1] = this._indexs[_loc_4][1] + event.text.length;
                    _loc_4++;
                }
            }
            if (this._strlength + this.countNum(event.text) > MAX_WORD)
            {
                event.preventDefault();
            }
            return;
        }// end function

        private function __inputChange(event:Event) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = text;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._indexs.length)
            {
                
                _loc_3 = _loc_2.indexOf(this._goods[_loc_5].text());
                _loc_6 = _loc_2.slice(this._indexs[_loc_5][0], (this._indexs[_loc_5][1] + 1));
                _loc_7 = this.preChangeLength - length;
                _loc_7 = _loc_7 > 0 ? (_loc_7) : (1);
                if (_loc_3 > -1 && this.isInLink(text, this._goods[_loc_5].text(), this._indexs[_loc_5][0], this._indexs[_loc_5][1], _loc_7))
                {
                    this._indexs[_loc_5][0] = _loc_3 + _loc_4;
                    this._indexs[_loc_5][1] = _loc_3 + this.getPropNameLengthByText(this._goods[_loc_5] as ChatText) + _loc_4;
                    _loc_4 = _loc_4 + this.getPropNameLengthByText(this._goods[_loc_5] as ChatText);
                    _loc_2 = _loc_2.replace(this._goods[_loc_5].text(), "");
                }
                else
                {
                    this._indexs.splice(_loc_5, 1);
                    this._goods.splice(_loc_5, 1);
                    _loc_5 = _loc_5 - 1;
                    this.recount();
                }
                _loc_5++;
            }
            _loc_2 = this.replace(text);
            htmlText = _loc_2;
            this._strlength = this.countNum(text);
            this.preChangeLength = text.length;
            return;
        }// end function

        public function recount() : void
        {
            var _loc_1:* = text;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this._indexs.length)
            {
                
                _loc_2 = _loc_1.indexOf(this._goods[_loc_4].text());
                if (_loc_2 == -1)
                {
                    this._indexs.splice(_loc_4, 1);
                    this._goods.splice(_loc_4, 1);
                    _loc_4 = _loc_4 - 1;
                    this.recount();
                }
                else
                {
                    this._indexs[_loc_4][0] = _loc_2 + _loc_3;
                    this._indexs[_loc_4][1] = _loc_2 + this.getPropNameLengthByText(this._goods[_loc_4] as ChatText) + _loc_3;
                    _loc_3 = _loc_3 + this.getPropNameLengthByText(this._goods[_loc_4] as ChatText);
                    _loc_1 = _loc_1.replace(this._goods[_loc_4].text(), "");
                }
                _loc_4++;
            }
            return;
        }// end function

        public function getPropNameLengthByText(param1:ChatText) : int
        {
            return this.getPropNameLength(param1.prop);
        }// end function

        public function getPropNameLength(param1:PropInfo) : int
        {
            return PropUtil.getEquipName(param1, false, false).length + 2;
        }// end function

        private function isInLink(param1:String, param2:String, param3:int, param4:int, param5:int = 1) : Boolean
        {
            var _loc_8:* = null;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            while (_loc_7 <= param5)
            {
                
                _loc_8 = param1.slice(param3 - _loc_7, param4 - _loc_7);
                if (_loc_8 == param2)
                {
                    _loc_6 = true;
                    return _loc_6;
                }
                _loc_7++;
            }
            return _loc_6;
        }// end function

        public function caretInIndex(param1:int, param2:int, param3:int = 1) : Boolean
        {
            return caretIndex >= param1 - param3 && caretIndex <= param2 + param3;
        }// end function

        private function replace(param1:String) : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < this._indexs.length)
            {
                
                _loc_3 = _loc_3 + param1.slice(_loc_2, this._indexs[_loc_4][0]);
                _loc_3 = _loc_3 + this._goods[_loc_4].toText();
                _loc_2 = this._indexs[_loc_4][1];
                _loc_4++;
            }
            _loc_3 = _loc_3 + param1.slice(_loc_2);
            return _loc_3;
        }// end function

        public function accept(param1:PropInfo) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (length >= MAX_WORD || this._strlength + this.getPropNameLength(param1) > MAX_WORD)
            {
                ChatController.getInstance().systemCue(LanguageCfgObj.getInstance().getByIndex("10457"));
                return;
            }
            if (this._isDefault)
            {
                htmlText = "";
                this.isDefault = false;
            }
            this._indexs.push([length, length + this.getPropNameLength(param1)]);
            this._goods.push(new ChatText(param1));
            this.defaultTextFormat = defaultTextFormat;
            if (this.isMultine)
            {
                multiline = false;
            }
            htmlText = htmlText + this._goods[(this._goods.length - 1)].toText();
            if (this.isMultine)
            {
                multiline = true;
            }
            var _loc_2:* = htmlText;
            this._strlength = this.countNum(text);
            stage.focus = this;
            defaultTextFormat = this._format;
            setSelection(length, length);
            this.preChangeLength = text.length;
            return;
        }// end function

        private function makeClone(param1:Object) : Object
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeObject(param1);
            _loc_2.position = 0;
            return _loc_2.readObject();
        }// end function

        public function setMsg(param1:String, param2:Vector.<ChatGoodInfo>) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            stage.focus = FrameworkGlobal.stage;
            this._indexs.splice(0);
            this._goods.splice(0);
            var _loc_5:* = "";
            var _loc_7:* = 0;
            while (_loc_7 < param1.length)
            {
                
                _loc_6 = param1.charAt(_loc_7);
                if (_loc_6 == "\f")
                {
                    param2[_loc_3].index = _loc_7 - _loc_3;
                    _loc_3++;
                    ;
                }
                _loc_7++;
            }
            param1 = param1.split("\f").join("");
            if (this._isDefault)
            {
                this.isDefault = false;
            }
            _loc_3 = 0;
            var _loc_8:* = 0;
            _loc_7 = 0;
            while (_loc_7 < param2.length)
            {
                
                _loc_5 = _loc_5 + param1.slice(_loc_3, param2[_loc_7].index);
                _loc_8 = _loc_8 + (param2[_loc_7].index - _loc_3);
                _loc_9 = param2[_loc_7].propInfo as PropInfo;
                if (!_loc_9)
                {
                }
                else
                {
                    _loc_10 = new ChatText(_loc_9);
                    _loc_4 = _loc_8 + this.getPropNameLength(param2[_loc_7].propInfo);
                    if (_loc_8 == 0)
                    {
                        _loc_11 = _loc_8;
                    }
                    else
                    {
                        _loc_11 = _loc_8;
                    }
                    this._indexs.push([_loc_11, _loc_4]);
                    _loc_8 = _loc_8 + this.getPropNameLength(param2[_loc_7].propInfo);
                    _loc_5 = _loc_5 + _loc_10.toText();
                    _loc_3 = param2[_loc_7].index;
                    this._goods.push(_loc_10);
                }
                _loc_7++;
            }
            _loc_5 = _loc_5 + param1.slice(_loc_3);
            htmlText = _loc_5;
            stage.focus = this;
            setSelection(length, length);
            this.preChangeLength = param1.length;
            return;
        }// end function

        public function addFace(param1:String) : void
        {
            stage.focus = this;
            this._faceCount = RichTxtUtil.countFace(htmlText);
            if (this._faceCount >= this.MAX_FACE_COUNT)
            {
                ChatController.getInstance().systemCue(LanguageCfgObj.getInstance().getByIndex("10458"));
            }
            else if (length >= MAX_WORD || this._strlength + 3 > MAX_WORD)
            {
                ChatController.getInstance().systemCue(LanguageCfgObj.getInstance().getByIndex("10457"));
            }
            else
            {
                appendText(param1);
            }
            this.isDefault = false;
            this._strlength = this.countNum(text);
            setSelection(length, length);
            this.preChangeLength = text.length;
            return;
        }// end function

        public function getMsg() : Array
        {
            var _loc_4:* = 0;
            var _loc_1:* = new TextField();
            _loc_1.htmlText = htmlText;
            var _loc_2:* = _loc_1.text;
            var _loc_3:* = "";
            var _loc_5:* = 0;
            while (_loc_5 < this._goods.length)
            {
                
                _loc_3 = _loc_3 + _loc_2.slice(_loc_4, this._indexs[_loc_5][0]);
                _loc_3 = _loc_3 + "\f";
                _loc_4 = this._indexs[_loc_5][1];
                _loc_5++;
            }
            if (_loc_4 > 0)
            {
                _loc_3 = _loc_3 + _loc_2.slice(_loc_4);
            }
            else
            {
                _loc_3 = _loc_3 + _loc_2.slice(_loc_4);
            }
            var _loc_6:* = [_loc_3, this.makeGoods()];
            return [_loc_3, this.makeGoods()];
        }// end function

        public function makeGoods() : Vector.<ChatGoodInfo>
        {
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<ChatGoodInfo>;
            var _loc_2:* = 0;
            while (_loc_2 < this._goods.length)
            {
                
                _loc_3 = new ChatGoodInfo();
                _loc_3.propInfo = this._goods[_loc_2].prop;
                _loc_3.index = this._indexs[_loc_2];
                _loc_1.push(_loc_3);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        private function checkIndex() : Array
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._indexs.length)
            {
                
                if (caretIndex > this._indexs[_loc_2][0])
                {
                    _loc_1 = _loc_2 + 1;
                }
                if (caretIndex > this._indexs[_loc_2][0] && caretIndex < this._indexs[_loc_2][1])
                {
                    return [_loc_2, _loc_1];
                }
                _loc_2++;
            }
            return [-1, _loc_1];
        }// end function

        private function countNum(param1:String) : int
        {
            var _loc_5:* = null;
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = param1.charAt(_loc_4);
                if (StringUtil.isChinese(_loc_5))
                {
                    _loc_3 = _loc_3 + 2;
                }
                else
                {
                    _loc_3 = _loc_3 + 1;
                }
                _loc_4++;
            }
            if (this._guildChat)
            {
                this._guildChat.decide(_loc_3);
            }
            if (this._horn)
            {
                this._horn.decide(_loc_3);
            }
            this.assignActiveTime();
            return _loc_3;
        }// end function

        private function assignActiveTime() : void
        {
            var _loc_1:* = getTimer();
            if (this._guildChat)
            {
                ChatController.getInstance().guild_active_time = _loc_1;
            }
            else if (this._horn)
            {
                ChatController.getInstance().horn_active_time = _loc_1;
            }
            else
            {
                ChatController.getInstance().chat_active_time = _loc_1;
            }
            return;
        }// end function

        public function clear() : void
        {
            this._goods.splice(0);
            this._indexs.splice(0);
            htmlText = "";
            this._strlength = 0;
            return;
        }// end function

        public function setDefault() : void
        {
            htmlText = this.template;
            this.isDefault = true;
            return;
        }// end function

    }
}
