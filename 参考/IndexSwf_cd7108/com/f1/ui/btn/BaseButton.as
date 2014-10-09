package com.f1.ui.btn
{
    import com.f1.interfaces.ui.button.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BaseButton extends Component implements IBaseButton
    {
        public var _labelTxt:TextField;
        private var _labelStr:String;
        public var _state:String = "up";
        public var _name:String = "";
        protected var _enable:Boolean = true;
        protected var _selected:Boolean = false;
        private var _downType:Boolean = false;
        protected var _obj:Object;
        protected var tfs:Object;
        private var _gap:Boolean;

        public function BaseButton(param1 = null, param2:Boolean = false, param3 = null)
        {
            this.tfs = {};
            this.initBaseButtonUI(param1, param2, param3);
            return;
        }// end function

        public function setIcon(param1:String, param2:uint, param3:uint) : void
        {
            var _loc_4:* = ToolKit.getNew(param1);
            _loc_4.x = param2;
            _loc_4.y = param3;
            addChild(_loc_4);
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get label() : String
        {
            return this._labelStr;
        }// end function

        protected function initBaseButtonUI(param1, param2:Boolean = false, param3 = null) : void
        {
            if (param1 == null)
            {
                return;
            }
            initComponentUI(param1);
            if (param3)
            {
                this.obj = param3;
            }
            this._downType = param2;
            this.buttonMode = true;
            this.enabled = true;
            this.initLabel();
            return;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set obj(param1) : void
        {
            this._obj = param1;
            return;
        }// end function

        override public function setHeight(param1:Number) : void
        {
            if (display)
            {
                display.height = param1;
                setWH(this.width, this.height);
            }
            return;
        }// end function

        protected function initLabel() : void
        {
            var _loc_1:* = null;
            if (display != null)
            {
                if (this._labelTxt != getDisplayChildByName("txt"))
                {
                    this._labelTxt = getDisplayChildByName("txt");
                    this._labelTxt.mouseEnabled = false;
                    if (this._labelTxt)
                    {
                        this._labelTxt.htmlText = "";
                        this._labelTxt.mouseEnabled = false;
                        if (this._labelStr)
                        {
                            this.setText(this._labelStr, this._gap);
                        }
                        _loc_1 = this._labelTxt.getTextFormat();
                        if (_loc_1 && _loc_1.align)
                        {
                            this._labelTxt.autoSize = _loc_1.align;
                        }
                    }
                }
            }
            return;
        }// end function

        public function setTextFormat(param1:Object) : void
        {
            return;
        }// end function

        override public function setDisplay(param1) : void
        {
            super.setDisplay(param1);
            this.initLabel();
            return;
        }// end function

        public function setTextLabelW(param1:Number) : void
        {
            this._labelTxt.width = param1;
            return;
        }// end function

        public function setText(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (this._labelTxt != null)
            {
                this._labelStr = param1;
                this._labelTxt.htmlText = param1;
                if (param2 && this._labelTxt.text.length == 2)
                {
                    _loc_3 = this._labelTxt.defaultTextFormat;
                    _loc_3.letterSpacing = 8;
                    this._labelTxt.setTextFormat(_loc_3, 0, 1);
                }
                this._gap = param2;
            }
            return;
        }// end function

        public function getText() : String
        {
            return this._labelTxt.text;
        }// end function

        public function get labelTxt() : TextField
        {
            return this._labelTxt;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            this._enable = param1;
            this.mouseEnabled = param1;
            this.useHandCursor = param1;
            this.mouseChildren = false;
            if (param1)
            {
                this._selected = false;
                this.showState("up");
                this.addListener();
            }
            else
            {
                this.showState("disabled");
                this.removeListener();
            }
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enable;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this.setSelected(param1);
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            if (!this.enabled)
            {
                return;
            }
            this._selected = param1;
            if (param1)
            {
                this.showState("selected");
                this.removeListener();
            }
            else
            {
                this.showState("up");
                this.addListener();
            }
            if (param2)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
            return;
        }// end function

        public function reset() : void
        {
            this.selected = false;
            this.showState();
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set downType(param1:Boolean) : void
        {
            this._downType = param1;
            return;
        }// end function

        private function __downTypeUp(event:MouseEvent) : void
        {
            this.selected = !this._selected;
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.addEvtListener(MouseEvent.MOUSE_DOWN, this.__down);
            this.addEvtListener(MouseEvent.MOUSE_UP, this.__up);
            if (this._downType)
            {
                this.addEvtListener(MouseEvent.CLICK, this.__downTypeUp);
            }
            return;
        }// end function

        protected function removeListener() : void
        {
            this.removeEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.removeEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__down);
            this.removeEvtListener(MouseEvent.MOUSE_UP, this.__up);
            if (!this._downType)
            {
                this.removeEventListener(MouseEvent.CLICK, this.__downTypeUp);
            }
            return;
        }// end function

        public function showState(param1:String = "up") : void
        {
            if (display == null)
            {
                return;
            }
            this._state = param1;
            switch(param1)
            {
                case "up":
                {
                    break;
                }
                case "over":
                {
                    break;
                }
                case "down":
                {
                    break;
                }
                case "selected":
                {
                    break;
                }
                case "disabled":
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            this.initLabel();
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (this.enabled)
            {
                this.showState("over");
            }
            else
            {
                this.showState("disabled");
            }
            return;
        }// end function

        protected function __up(event:MouseEvent) : void
        {
            if (this.enabled)
            {
                if (this.selected)
                {
                    this.showState("selected");
                }
                else
                {
                    this.showState("over");
                }
            }
            else
            {
                this.showState("disabled");
            }
            return;
        }// end function

        public function __out(event:MouseEvent) : void
        {
            if (this.enabled)
            {
                if (this.selected)
                {
                    this.showState("selected");
                }
                else
                {
                    this.showState("up");
                }
            }
            else
            {
                this.showState("disabled");
            }
            return;
        }// end function

        protected function __down(event:MouseEvent) : void
        {
            if (this.enabled)
            {
                this.showState("down");
            }
            else
            {
                this.showState("disabled");
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this._obj = null;
            super.finalize();
            return;
        }// end function

    }
}
