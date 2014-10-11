package com.game.mail.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.game.mail.bean.*;
    import com.game.mail.control.*;
    import com.game.mail.events.*;
    import com.game.utils.*;
    import com.view.*;
    import flash.events.*;

    public class MailListView extends Component
    {
        private var _pageCounter:PageCounter;
        private var _container:HBox;
        private var _preBtn:BaseButton;
        private var _nextBtn:BaseButton;
        private var _delReadBtn:BaseButton;
        private var _delBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _selectBtn:BaseButton;
        private var _type:int = 2;
        private var _info:Vector.<MailSummaryInfo>;
        private var _control:MailController;

        public function MailListView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            this.addListener();
            this._control = MailController.getInstance();
            return;
        }// end function

        public function get info() : Vector.<MailSummaryInfo>
        {
            return this._info;
        }// end function

        public function set info(param1:Vector.<MailSummaryInfo>) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._info.length)
            {
                
                this._container.getContent(_loc_1).info = this._info[_loc_1];
                _loc_1++;
            }
            _loc_1 = this._info.length;
            while (_loc_1 < MailController.PAGESIZE)
            {
                
                this._container.getContent(_loc_1).info = null;
                _loc_1++;
            }
            this._pageCounter.setVlaue(this._control.getPage(this._control.type), this._control.getPageCount(this._control.type));
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._pageCounter = new PageCounter(getDisplayChildByName("pagecounter"));
            this._container = new HBox();
            this._container.intervalY = 2;
            this._container.move(getDisplayChildByName("item_1").x, getDisplayChildByName("item_1").y);
            addChild(this._container);
            this._selectBtn = new BaseButton(getDisplayChildByName("btn_select"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._delBtn = new BaseButton(getDisplayChildByName("btn_delete"));
            this._delBtn.setText(LanguageCfgObj.getInstance().getByIndex("10909"));
            this._delReadBtn = new BaseButton(getDisplayChildByName("btn_delReaded"));
            this._delReadBtn.setText(LanguageCfgObj.getInstance().getByIndex("10910"));
            var _loc_1:* = 0;
            while (_loc_1 < MailController.PAGESIZE)
            {
                
                _loc_2 = new MailItem(getDisplayChildByName("item_" + (_loc_1 + 1)));
                this._container.add(_loc_2);
                _loc_2.info = null;
                _loc_1++;
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__cancelClick);
            this._selectBtn.addEvtListener(MouseEvent.CLICK, this.__selectClick);
            this._pageCounter.addEvtListener(Event.CHANGE, this.__pageChange);
            this._delBtn.addEvtListener(MouseEvent.CLICK, this.__delClick);
            this._delReadBtn.addEvtListener(MouseEvent.CLICK, this.__delReadClick);
            this._container.addEvtListener(MailEvent.SELECT, this.__itemClick);
            return;
        }// end function

        private function __itemClick(event:MailEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = event.target as MailItem;
            if (_loc_2 && _loc_2.info)
            {
                _loc_3 = this._container.contents.indexOf(_loc_2);
                _loc_3 = MailController.getInstance().getPageIndex(_loc_3);
                MailController.getInstance().getInfo(_loc_2.info.mailid, _loc_3);
            }
            return;
        }// end function

        private function __selectClick(event:MouseEvent) : void
        {
            var _loc_2:* = this._container.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._container.getContent(_loc_3).select = true;
                _loc_3++;
            }
            return;
        }// end function

        private function __cancelClick(event:MouseEvent) : void
        {
            var _loc_2:* = this._container.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._container.getContent(_loc_3).select = false;
                _loc_3++;
            }
            return;
        }// end function

        private function __pageChange(event:Event) : void
        {
            var _loc_2:* = this._pageCounter.curPage;
            if (MailController.getInstance().type == 2)
            {
                MailController.getInstance().curTotalPage = _loc_2;
            }
            else if (MailController.getInstance().type == 1)
            {
                MailController.getInstance().curReadedPage = _loc_2;
            }
            else
            {
                MailController.getInstance().curUnreadPage = _loc_2;
            }
            MailController.getInstance().getList();
            return;
        }// end function

        public function setPageCount(param1:int) : void
        {
            this._pageCounter.curPage = param1;
            return;
        }// end function

        private function __delReadClick(event:MouseEvent) : void
        {
            var _loc_2:* = new Vector.<MailSummaryInfo>;
            var _loc_3:* = new Vector.<long>;
            var _loc_4:* = MailController.getInstance().readedList.length;
            _loc_4 = Math.min(_loc_4, 5);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (MailController.getInstance().readedList[_loc_5].btRead == 1)
                {
                    _loc_2.push(MailController.getInstance().readedList[_loc_5]);
                    _loc_3.push(MailController.getInstance().readedList[_loc_5].mailid);
                }
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (_loc_2[_loc_5].btRead == 0 || _loc_2[_loc_5].btAccessory == 1)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12092"), LanguageCfgObj.getInstance().getByIndex("12093"), [_loc_3], this.doDel);
                    return;
                }
                _loc_5++;
            }
            this.doDel(_loc_3);
            return;
        }// end function

        private function __delClick(event:MouseEvent) : void
        {
            var _loc_2:* = new Vector.<MailSummaryInfo>;
            var _loc_3:* = new Vector.<long>;
            var _loc_4:* = this._container.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (this._container.getContent(_loc_5).visible && this._container.getContent(_loc_5).select == true)
                {
                    _loc_2.push(this._container.getContent(_loc_5).info as MailSummaryInfo);
                    _loc_3.push((this._container.getContent(_loc_5).info as MailSummaryInfo).mailid);
                }
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (_loc_2[_loc_5].btRead == 0 || _loc_2[_loc_5].btAccessory == 1)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12094"), "", [_loc_3], this.doDel);
                    return;
                }
                _loc_5++;
            }
            this.doDel(_loc_3);
            return;
        }// end function

        private function doDel(param1:Vector.<long>) : void
        {
            MailController.getInstance().delMail(0, param1);
            return;
        }// end function

    }
}
