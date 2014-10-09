package com.game.chat.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.chat.consts.*;
    import com.game.chat.control.*;
    import com.game.chat.events.*;
    import com.game.chat.model.*;
    import com.game.chat.utils.*;
    import com.model.vo.*;
    import com.riaidea.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class ChatOutPut extends BaseSprite
    {
        private var _scroll:ChatScroller;
        private var _output:RichTextField;
        private var _bg:Sprite;
        private var _width:int;
        private var _height:int;
        public var MAXW:int = 400;
        private var _stopAutoRoll:Boolean;
        private var _drawSp:Sprite;
        private var _corner:BaseButton;
        private var _panelWidth:int;
        private var _funBuffer:FunctionBuffer;
        private var _arr:LoopArray;
        private const LABALENGTH:int = 20;
        private var _releaseTextEventid:int;
        private var _numCount:int;
        private var stepTime:int;
        private var _appendInGap:int = 3;
        private var _indexOfArr:int;
        private static const MAX_LINE:uint = 100;
        private static const MAXH:int = 400;
        private static const MINW:int = 360;
        private static const MINH:int = 90;

        public function ChatOutPut(param1:int, param2:int)
        {
            this._width = param1;
            this._height = param2;
            this._bg = ToolKit.getNew("transparentChatBg");
            addChild(this._bg);
            this._bg.width = param1;
            this._bg.height = param2 + 24;
            this._output = new RichTextField();
            this._output.type = RichTextField.DYNAMIC;
            var _loc_3:* = new TextFormat("SimSun", 12, 16777215, false, false, false);
            _loc_3.leading = 5;
            this._output.defaultTextFormat = _loc_3;
            this._output.textfield.mouseWheelEnabled = false;
            this._output.textfield.selectable = false;
            this._output.textfield.filters = [FrameworkGlobal.BLACK_FILTER];
            this._output.autoScroll = true;
            this._output.textfield.wordWrap = true;
            this._output.setSize(param1 - 30, param2);
            this._output.mouseEnabled = false;
            this._output.textfield.htmlText = "";
            this._output.textfield.text = "";
            this._output.html = true;
            this._output.placeholderMarginH = 1;
            this._output.lineHeight = 40;
            this._output.x = 19;
            this._output.y = 2;
            addChild(this._output);
            addEvtListener(MouseEvent.MOUSE_WHEEL, this.__wheel);
            this._scroll = new ChatScroller(param1, param2);
            this._scroll.content = this._output.textfield;
            this._scroll.y = 2;
            this._scroll.setWH(param1, param2 + this.LABALENGTH);
            addChild(this._scroll);
            this._output.addEventListener(TextEvent.LINK, this.__link, false, 0, true);
            addEvtListener(MouseEvent.CLICK, this.__click);
            addEventListener(KeyboardEvent.KEY_DOWN, this.__changeStageFocus, true);
            this._corner = new BaseButton("btnChatCorner");
            this._corner.addEvtListener(MouseEvent.MOUSE_DOWN, this.__dragDown);
            addChild(this._corner);
            this._panelWidth = param1;
            this.setChatAlpha(0.2);
            this.setInitSize(param1, param2);
            addEventListener(KeyboardEvent.KEY_DOWN, this.__changeStageFocus, true);
            this._funBuffer = new FunctionBuffer(0.2);
            return;
        }// end function

        private function __changeStageFocus(event:KeyboardEvent) : void
        {
            if (FrameworkGlobal.stage && FrameworkGlobal.stage.focus == this._output.textfield)
            {
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
            }
            return;
        }// end function

        public function get panelWidth() : int
        {
            return this._panelWidth;
        }// end function

        public function set panelWidth(param1:int) : void
        {
            this._panelWidth = param1;
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

        public function get arr() : LoopArray
        {
            return this._arr;
        }// end function

        public function set arr(param1:LoopArray) : void
        {
            this._arr = param1;
            return;
        }// end function

        private function setChatAlpha(param1:Number) : void
        {
            this._corner.alpha = param1;
            this._bg.alpha = param1 == 0 ? (0.2) : (1);
            this._scroll.scroll.alpha = param1;
            return;
        }// end function

        public function out() : void
        {
            this.setChatAlpha(0);
            this._scroll.updateThumb();
            this._scroll.scrollToBottom();
            return;
        }// end function

        public function over() : void
        {
            this.setChatAlpha(1);
            return;
        }// end function

        public function get stopAutoRoll() : Boolean
        {
            return this._stopAutoRoll;
        }// end function

        public function set stopAutoRoll(param1:Boolean) : void
        {
            this._stopAutoRoll = param1;
            if (!param1)
            {
                this.out();
            }
            return;
        }// end function

        public function setInitSize(param1:int, param2:int) : void
        {
            this._bg.width = param1;
            this._bg.height = param2 + 24;
            this._scroll.setWH(param1, param2 + this.LABALENGTH);
            this._output.setSize(param1 - 30, param2);
            this._scroll.updateThumb();
            this._scroll.scrollToBottom();
            y = -param2;
            this._corner.x = param1 - this._corner.width;
            this._corner.y = 0;
            return;
        }// end function

        private function setOutSize(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            this._bg.width = param1;
            this._bg.height = param2 + 24;
            _loc_3 = param2;
            this._scroll.setWH(param1, param2 + this.LABALENGTH);
            if (this._output.width != param1 - 30 || this._output.height != param2)
            {
                this._output.setSize(param1 - 30, param2);
                if (this._arr)
                {
                    this.addOutTxts(this._arr);
                }
            }
            this._scroll.updateThumb();
            this._scroll.scrollToBottom();
            y = -param2;
            return;
        }// end function

        public function repaint() : void
        {
            this.addOutTxts(ChatModel.getInstance().curArr);
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            ChatModel.getInstance().inTextEvent = true;
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            clearTimeout(this._releaseTextEventid);
            this._releaseTextEventid = setTimeout(this.releaseTextEvent, 50);
            return;
        }// end function

        private function releaseTextEvent() : void
        {
            ChatModel.getInstance().inTextEvent = false;
            return;
        }// end function

        private function __appendInEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = this;
            var _loc_5:* = this.stepTime + 1;
            _loc_4.stepTime = _loc_5;
            if (this.stepTime == this._appendInGap)
            {
                this.stepTime = 0;
                if (this._indexOfArr == this._arr.length)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__appendInEnterFrame);
                    this._indexOfArr = 0;
                    return;
                }
                var _loc_4:* = this;
                var _loc_5:* = this._numCount + 1;
                _loc_4._numCount = _loc_5;
                _loc_2 = this.arr.getObj(this._indexOfArr) as ChatInfo;
                var _loc_4:* = this;
                var _loc_5:* = this._indexOfArr + 1;
                _loc_4._indexOfArr = _loc_5;
                if (_loc_2 == null)
                {
                    return;
                }
                _loc_3 = ChatUtil.makeSrc(_loc_2);
                if (_loc_3.length)
                {
                    this._output.append(_loc_2.txt, _loc_3, true);
                }
                else
                {
                    this._output.append(_loc_2.txt, null, true);
                }
                this._scroll.updateThumb();
            }
            return;
        }// end function

        public function addOutTxts(param1:LoopArray) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = getTimer();
            this._funBuffer.removeItemAll();
            this._output.clear();
            this._arr = param1;
            this._numCount = 0;
            this.stepTime = 0;
            this._indexOfArr = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                var _loc_6:* = this;
                var _loc_7:* = this._numCount + 1;
                _loc_6._numCount = _loc_7;
                _loc_4 = param1.getObj(_loc_3) as ChatInfo;
                if (_loc_4 == null)
                {
                }
                else
                {
                    _loc_5 = ChatUtil.makeSrc(_loc_4);
                    if (_loc_5.length)
                    {
                        this._output.append(_loc_4.txt, _loc_5, true);
                    }
                    else
                    {
                        this._output.append(_loc_4.txt, null, true);
                    }
                }
                _loc_3++;
            }
            this._scroll.updateThumb();
            return;
        }// end function

        public function addOutTxt(param1:ChatInfo) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_2:* = ChatUtil.makeSrc(param1);
            if (_loc_2.length)
            {
                this._funBuffer.addItem(this.appendTxt, [param1.txt, _loc_2, true]);
            }
            else
            {
                this._funBuffer.addItem(this.appendTxt, [param1.txt, null, true]);
            }
            return;
        }// end function

        private function appendTxt(param1:String, param2:Array, param3:Boolean = false) : void
        {
            if (this._numCount >= MAX_LINE)
            {
                if (this._arr)
                {
                    this.addOutTxts(this._arr);
                    return;
                }
                this._output.clear();
            }
            var _loc_4:* = this._output.textfield.scrollV;
            var _loc_6:* = this;
            var _loc_7:* = this._numCount + 1;
            _loc_6._numCount = _loc_7;
            var _loc_5:* = true;
            if (this._output.textfield.scrollV != this._output.textfield.maxScrollV)
            {
                _loc_5 = false;
            }
            this._output.append(param1, param2, false);
            if (this._stopAutoRoll || !_loc_5)
            {
                this._output.textfield.scrollV = _loc_4;
            }
            if (_loc_5)
            {
                this._scroll.updateThumb();
            }
            return;
        }// end function

        public function clear() : void
        {
            this._output.clear();
            return;
        }// end function

        private function __dragDown(event:MouseEvent) : void
        {
            this._corner.startDrag();
            if (this._drawSp == null)
            {
                this._drawSp = new Sprite();
            }
            this._drawSp.graphics.clear();
            addChild(this._drawSp);
            Global.primaryCursorManager.showDragIcon();
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.__move, false, 0, true);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.__dragUp, false, 0, true);
            return;
        }// end function

        private function __move(event:MouseEvent) : void
        {
            var _loc_2:* = globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = _loc_2.x;
            var _loc_4:* = _loc_2.y;
            var _loc_5:* = _loc_3;
            var _loc_6:* = this._bg.height - _loc_4;
            if (this._bg.height - _loc_4 < MINH)
            {
                _loc_6 = MINH;
            }
            if (_loc_5 < ChatConst.CHAT_WIDTH)
            {
                _loc_5 = ChatConst.CHAT_WIDTH;
            }
            if (_loc_5 > this.MAXW)
            {
                _loc_5 = this.MAXW;
                this._corner.visible = false;
            }
            if (_loc_6 > MAXH)
            {
                _loc_6 = MAXH;
                this._corner.visible = false;
            }
            this._drawSp.graphics.clear();
            this._drawSp.graphics.lineStyle(2, 16776960);
            this._drawSp.graphics.moveTo(0, this._bg.height);
            this._drawSp.graphics.lineTo(_loc_5, this._bg.height);
            this._drawSp.graphics.lineTo(_loc_5, this._bg.height - _loc_6);
            this._drawSp.graphics.lineTo(0, this._bg.height - _loc_6);
            return;
        }// end function

        private function __dragUp(event:MouseEvent) : void
        {
            Global.primaryCursorManager.hide();
            this._corner.stopDrag();
            var _loc_2:* = globalToLocal(new Point(event.stageX, event.stageY));
            if (this._drawSp)
            {
                this._drawSp.parent.removeChild(this._drawSp);
            }
            var _loc_3:* = _loc_2.x;
            var _loc_4:* = _loc_2.y;
            var _loc_5:* = _loc_3;
            var _loc_6:* = this._bg.height - _loc_4;
            if (this._bg.height - _loc_4 < MINH)
            {
                _loc_6 = MINH;
            }
            if (_loc_5 < ChatConst.CHAT_WIDTH)
            {
                _loc_5 = ChatConst.CHAT_WIDTH;
            }
            if (_loc_5 > this.MAXW)
            {
                _loc_5 = this.MAXW;
            }
            if (_loc_6 > MAXH)
            {
                _loc_6 = MAXH;
            }
            this._panelWidth = _loc_5;
            this.rebgsize(_loc_5, _loc_6);
            dispatchEvent(new ChatEvent(ChatEvent.RISIZE_CHAT, {w:_loc_5, h:_loc_6}));
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.__move, false);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__dragUp, false);
            return;
        }// end function

        public function resizeByComponent(param1:int, param2:int) : void
        {
            this._panelWidth = param1;
            this.rebgsize(param1, param2);
            return;
        }// end function

        private function rebgsize(param1:int, param2:int) : void
        {
            this._corner.x = param1 - this._corner.width;
            this._corner.y = 0;
            this._corner.visible = true;
            this.setOutSize(param1, param2);
            return;
        }// end function

        public function changeMode(param1:int) : void
        {
            this.rebgsize(this._panelWidth, param1);
            return;
        }// end function

        public function setBgAlpha(param1:Number) : void
        {
            this._bg.alpha = param1;
            return;
        }// end function

    }
}
