package com.view
{
    import com.events.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class PageCounter extends Component
    {
        private var _leftBtn:BaseButton;
        private var _rightBtn:BaseButton;
        private var _text:TextField;
        private var _pageTotal:int;
        private var _curPage:int = 1;
        private var _disable:Boolean;

        public function PageCounter(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            this._leftBtn.addEvtListener(MouseEvent.CLICK, this.__click);
            this._rightBtn.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        public function get rightBtn() : BaseButton
        {
            return this._rightBtn;
        }// end function

        public function set rightBtn(param1:BaseButton) : void
        {
            this._rightBtn = param1;
            return;
        }// end function

        public function get leftBtn() : BaseButton
        {
            return this._leftBtn;
        }// end function

        public function set leftBtn(param1:BaseButton) : void
        {
            this._leftBtn = param1;
            return;
        }// end function

        public function get disable() : Boolean
        {
            return this._disable;
        }// end function

        public function set disable(param1:Boolean) : void
        {
            this._disable = param1;
            if (this.disable)
            {
                this._text.text = "";
            }
            return;
        }// end function

        public function get pageTotal() : int
        {
            return this._pageTotal;
        }// end function

        public function set pageTotal(param1:int) : void
        {
            this._pageTotal = param1;
            if (this._curPage)
            {
                this.setVlaue(this._curPage, this._pageTotal);
            }
            return;
        }// end function

        public function get curPage() : int
        {
            return this._curPage;
        }// end function

        public function set curPage(param1:int) : void
        {
            this._curPage = param1;
            if (this._pageTotal)
            {
                this.setVlaue(this._curPage, this._pageTotal);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._leftBtn = new BaseButton(getDisplayChildByName("btn_left"));
            this._rightBtn = new BaseButton(getDisplayChildByName("btn_right"));
            this._text = getDisplayChildByName("txt_page");
            return;
        }// end function

        public function setVlaue(param1:int, param2:int, param3:Boolean = false) : void
        {
            if (!param3)
            {
                if (this.disable)
                {
                    return;
                }
            }
            if (this._text)
            {
                this._text.text = param1 + "/" + param2;
            }
            this._pageTotal = param2;
            this._curPage = param1;
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = this._curPage;
            switch(event.target)
            {
                case this._leftBtn:
                {
                    if (this.disable)
                    {
                        _loc_3 = _loc_2 - 1;
                        _loc_3 = Math.max(1, Math.min(_loc_3, this._pageTotal));
                        dispatchEvent(new PageEvent(PageEvent.PAGE_CHANGE, new PageCountInfo(-1, _loc_3)));
                        return;
                    }
                    _loc_2 = _loc_2 - 1;
                    if (_loc_2 < 1)
                    {
                        _loc_2 = 1;
                    }
                    if (this._curPage != _loc_2)
                    {
                        this._curPage = _loc_2;
                        dispatchEvent(new Event(Event.CHANGE));
                        this.setVlaue(this._curPage, this._pageTotal);
                    }
                    break;
                }
                case this._rightBtn:
                {
                    if (this.disable)
                    {
                        _loc_3 = _loc_2 + 1;
                        _loc_3 = Math.max(1, Math.min(_loc_3, this._pageTotal));
                        dispatchEvent(new PageEvent(PageEvent.PAGE_CHANGE, new PageCountInfo(1, _loc_3)));
                        return;
                    }
                    _loc_2++;
                    if (_loc_2 > this._pageTotal)
                    {
                        _loc_2 = this._pageTotal;
                    }
                    if (this._curPage != _loc_2)
                    {
                        this._curPage = _loc_2;
                        dispatchEvent(new Event(Event.CHANGE));
                        this.setVlaue(this._curPage, this._pageTotal);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
