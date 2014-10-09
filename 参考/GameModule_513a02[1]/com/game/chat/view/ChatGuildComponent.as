package com.game.chat.view
{
    import com.f1.*;
    import com.game.chat.control.*;
    import com.game.chat.utils.*;
    import com.game.guild.control.*;
    import com.model.vo.*;
    import com.riaidea.text.*;
    import flash.events.*;
    import flash.text.*;

    public class ChatGuildComponent extends BaseSprite
    {
        private var _output:RichTextField;
        private var _scroll:ChatScroller;
        private var _arr:LoopArray;
        private var groupArr:LoopArray;
        private var _keys:Array;

        public function ChatGuildComponent(param1:int, param2:int, param3:int, param4:int = 0)
        {
            this.groupArr = new LoopArray(25);
            this._keys = ["YY", "yy", "yY", "Yy", "QQ", "qq", "Qq", "qQ"];
            this._output = new RichTextField();
            this._output.type = RichTextField.DYNAMIC;
            var _loc_5:* = new TextFormat("SimSun", 12, 16777215, false, false, false);
            _loc_5.leading = 5;
            this._output.defaultTextFormat = _loc_5;
            this._output.textfield.mouseWheelEnabled = false;
            this._output.textfield.selectable = false;
            this._output.textfield.filters = [FrameworkGlobal.BLACK_FILTER];
            this._output.autoScroll = true;
            this._output.textfield.wordWrap = true;
            this._output.setSize(param1 - 20, param2);
            this._output.mouseEnabled = false;
            this._output.textfield.htmlText = "";
            this._output.textfield.text = "";
            this._output.html = true;
            this._output.placeholderMarginH = 1;
            this._output.lineHeight = 40;
            this._output.x = 0;
            this._output.y = 0;
            addChild(this._output);
            this._scroll = new ChatScroller(param1, param2);
            this._scroll.content = this._output.textfield;
            this._scroll.y = param4;
            this._scroll.x = param3;
            this._scroll.setWH(param1, param2);
            addChild(this._scroll);
            this._output.addEventListener(TextEvent.LINK, this.__link, false, 0, true);
            addEvtListener(MouseEvent.MOUSE_WHEEL, this.__wheel);
            return;
        }// end function

        public function pushMsg(param1:ChatInfo) : void
        {
            this.groupArr.push(param1);
            return;
        }// end function

        public function addOutTxt(param1:ChatInfo) : void
        {
            var _loc_2:* = ChatUtil.makeSrc(param1);
            this._output.append(param1.txt, _loc_2, false);
            this.checkKey(param1.txt);
            this._scroll.updateThumb();
            return;
        }// end function

        private function __wheel(event:MouseEvent) : void
        {
            if (this._scroll)
            {
                this._scroll.wheel(event.delta);
            }
            return;
        }// end function

        public function addOutTxts() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._output.clear();
            this._arr = GuildControl.getInstance().groupArr;
            var _loc_1:* = 0;
            while (_loc_1 < this._arr.length)
            {
                
                _loc_2 = this._arr.getObj(_loc_1) as ChatInfo;
                if (_loc_2 == null)
                {
                }
                else
                {
                    _loc_3 = ChatUtil.makeSrc(_loc_2);
                    if (_loc_3.length)
                    {
                        this._output.append(_loc_2.txt, _loc_3, true);
                    }
                    else
                    {
                        this._output.append(_loc_2.txt, null, true);
                    }
                    this.checkKey(_loc_2.txt);
                }
                _loc_1++;
            }
            this._scroll.updateThumb();
            return;
        }// end function

        private function checkKey(param1:String) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._keys.length)
            {
                
                if (param1.indexOf(this._keys[_loc_2]) != -1)
                {
                    this._output.append(LanguageCfgObj.getInstance().getByIndex("10456"));
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        public function clear() : void
        {
            this._output.clear();
            return;
        }// end function

    }
}
