package com.f1.ui.btn
{
    import com.f1.interfaces.ui.button.*;
    import com.f1.ui.container.*;
    import flash.display.*;
    import flash.events.*;

    public class Buttons extends HBox
    {
        public var selectBtn:IBaseButton;
        public var preSelectedIndex:int;

        public function Buttons()
        {
            return;
        }// end function

        public function get selectIndex() : int
        {
            return _contents.indexOf(this.selectBtn);
        }// end function

        public function set selectIndex(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 >= 0)
            {
                _loc_2 = _contents[param1];
                if (_loc_2 && _loc_2.enabled)
                {
                    this.btnClick(_loc_2);
                }
            }
            else
            {
                this.doBtnClick();
            }
            return;
        }// end function

        public function get selectObj()
        {
            if (!this.selectBtn)
            {
                return null;
            }
            return this.selectBtn.obj;
        }// end function

        public function getBtnByIndex(param1:uint) : IBaseButton
        {
            return getContent(param1);
        }// end function

        public function getBtnByObj(param1) : IBaseButton
        {
            var _loc_2:* = null;
            for each (_loc_2 in _contents)
            {
                
                if (_loc_2.obj == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function setSelectBtn(param1:IBaseButton) : void
        {
            if (param1 && param1.enabled)
            {
                this.btnClick(param1);
            }
            else
            {
                this.doBtnClick();
            }
            return;
        }// end function

        public function selectByObj(param1) : void
        {
            var _loc_2:* = this.getBtnByObj(param1);
            this.setSelectBtn(_loc_2);
            return;
        }// end function

        override public function add(param1, param2:Boolean = false, param3:int = 0, param4:int = 0) : DisplayObject
        {
            super.add(param1, param2, param3, param4);
            this.appendBtn(param1);
            return param1;
        }// end function

        public function appendBtn(param1:IBaseButton) : IBaseButton
        {
            if (_contents.indexOf(param1) == -1)
            {
                _contents.push(param1);
            }
            param1.addEvtListener(Event.CHANGE, this.__change);
            if (_contents.length == 1)
            {
                this.btnClick(param1);
            }
            return param1;
        }// end function

        private function __change(event:Event) : void
        {
            this.btnClick(event.currentTarget as IBaseButton);
            return;
        }// end function

        private function btnClick(param1:IBaseButton) : void
        {
            this.doBtnClick(param1);
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function doBtnClick(param1:IBaseButton = null) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                this.preSelectedIndex = this.selectIndex;
                this.selectBtn = param1;
                param1.setSelected(true, false);
                for each (_loc_2 in _contents)
                {
                    
                    if (_loc_2 != param1 && _loc_2.enabled)
                    {
                        _loc_2.setSelected(false, false);
                    }
                }
            }
            else
            {
                for each (_loc_2 in _contents)
                {
                    
                    if (_loc_2.enabled)
                    {
                        _loc_2.setSelected(false, false);
                    }
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            while (_contents.length > 0)
            {
                
                BaseButton(_contents.pop()).removeEventListener(Event.CHANGE, this.__change);
            }
            super.finalize();
            return;
        }// end function

    }
}
