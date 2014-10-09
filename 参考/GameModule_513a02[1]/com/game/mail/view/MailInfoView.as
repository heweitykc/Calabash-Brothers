package com.game.mail.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.game.guide.control.*;
    import com.game.mail.bean.*;
    import com.game.mail.control.*;
    import com.game.mail.events.*;
    import com.game.prompt.utils.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class MailInfoView extends Component
    {
        private var _item:MailItem;
        private var _contentTxt:TextField;
        private var _goodsContainer:HBox;
        private var _acceptBtn:BaseButton;
        private var _pagecounter:PageCounter;
        private var _backBtn:BaseButton;
        private var _delBtn:BaseButton;
        private var _info:MailDetailInfo;
        private var _holder:Sprite;
        private var _container:HBox;
        private var _scroll:ScrollPanel;
        private var _sp:Sprite;

        public function MailInfoView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            this.addListeners();
            return;
        }// end function

        public function get info() : MailDetailInfo
        {
            return this._info;
        }// end function

        public function set info(param1:MailDetailInfo) : void
        {
            this._info = param1;
            var _loc_2:* = new MailBriefInfo();
            _loc_2.btAccessory = param1.btAccessory;
            _loc_2.btRead = param1.btRead;
            _loc_2.btSystem = param1.btSystem;
            _loc_2.mailid = param1.mailid;
            _loc_2.nSendTime = param1.nSendTime;
            _loc_2.szSenderName = param1.szSenderName;
            _loc_2.szTitle = param1.szTitle;
            _loc_2.btAccessory = param1.btAccessory;
            this._acceptBtn.visible = this.info.btAccessory == 1;
            this._item.info = _loc_2;
            this._contentTxt.text = param1.szNotice;
            this.setGoods();
            if (MailController.getInstance().isShortCut)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._acceptBtn);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._item = new MailItem(getDisplayChildByName("item_1"));
            this._item.type = 1;
            this._scroll = new ScrollPanel(350, 140);
            this._contentTxt = getDisplayChildByName("txt_content");
            this._sp = new Sprite();
            this._scroll.x = this._contentTxt.x;
            this._scroll.y = this._contentTxt.y;
            this._container = new HBox();
            this._container.oneRow = 5;
            this._container.intervalX = 1;
            this._container.horizontal = true;
            this._holder = getDisplayChildByName("holder");
            this._container.x = this._holder.x - this._contentTxt.x;
            this._container.y = this._holder.y - this._contentTxt.y;
            var _loc_1:* = 0;
            this._contentTxt.y = 0;
            this._contentTxt.x = _loc_1;
            this._sp.addChild(this._contentTxt);
            this._sp.addChild(this._container);
            this._scroll.content = this._sp;
            addChild(this._scroll);
            this._acceptBtn = new BaseButton(getDisplayChildByName("btn_getitem"));
            this._acceptBtn.setText(LanguageCfgObj.getInstance().getByIndex("10903"));
            addChild(this._acceptBtn);
            this._pagecounter = new PageCounter(getDisplayChildByName("pagecounter"));
            this._pagecounter.disable = true;
            this._backBtn = new BaseButton(getDisplayChildByName("btn_back"));
            this._backBtn.setText(LanguageCfgObj.getInstance().getByIndex("10904"));
            this._delBtn = new BaseButton(getDisplayChildByName("btn_del"));
            this._delBtn.setText(LanguageCfgObj.getInstance().getByIndex("10905"));
            return;
        }// end function

        private function setGoods() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this._container.length - this._info.itemlist.length;
            if (_loc_1 > 0)
            {
                _loc_2 = this._container.length;
                _loc_3 = this._container.length - 1;
                while (_loc_3 >= _loc_2 - _loc_1)
                {
                    
                    this._container.removeByIndex(_loc_3);
                    _loc_3 = _loc_3 - 1;
                }
            }
            else if (_loc_1 < 0)
            {
                _loc_1 = -_loc_1;
                _loc_3 = 0;
                while (_loc_3 < _loc_1)
                {
                    
                    _loc_4 = new IconItem("backpackbox_bg");
                    var _loc_6:* = 2;
                    _loc_4.image.y = 2;
                    _loc_4.image.x = _loc_6;
                    this._container.add(_loc_4);
                    _loc_3++;
                }
            }
            _loc_3 = 0;
            while (_loc_3 < this._container.length)
            {
                
                _loc_5 = PropUtil.createItemByItemInfo(this._info.itemlist[_loc_3]);
                this._container.getContent(_loc_3).setInfo(_loc_5);
                _loc_3++;
            }
            this._scroll.updateThumb();
            return;
        }// end function

        public function getItemRes(param1:Vector.<int>) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                if (param1[_loc_2] < 0)
                {
                }
                else
                {
                    _loc_3 = this._container.localToGlobal(new Point(this._container.getContent(_loc_2).x, this._container.getContent(_loc_2).y));
                    ItemGetAnim.doFlyToBackPack(param1[_loc_2], _loc_3);
                }
                _loc_2++;
            }
            if (MailController.getInstance().isShortCut)
            {
                MailController.getInstance().closePanel();
            }
            return;
        }// end function

        private function addListeners() : void
        {
            this._acceptBtn.addEvtListener(MouseEvent.CLICK, this.__acceptClick);
            this._pagecounter.addEvtListener(PageEvent.PAGE_CHANGE, this.__pageChange);
            this._backBtn.addEvtListener(MouseEvent.CLICK, this.__backClick);
            this._delBtn.addEvtListener(MouseEvent.CLICK, this.__delClick);
            this._container.addEvtListener(MailEvent.SELECT, this.__selectedClick);
            return;
        }// end function

        private function __selectedClick(event:MailEvent) : void
        {
            var _loc_2:* = this._container.contents.indexOf(event.data);
            _loc_2 = MailController.getInstance().getPageIndex(_loc_2);
            MailController.getInstance().getInfo(event.data.info.mailid, _loc_2);
            return;
        }// end function

        private function __backClick(event:MouseEvent) : void
        {
            MailController.getInstance().changeToList();
            MailController.getInstance().returnBack();
            return;
        }// end function

        private function __delClick(event:MouseEvent) : void
        {
            var _loc_2:* = new Vector.<long>;
            _loc_2.push(this._info.mailid);
            if (this._info.btAccessory == 1)
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12092"), LanguageCfgObj.getInstance().getByIndex("12093"), [_loc_2], this.doDel);
                return;
            }
            MailController.getInstance().delMail(0, _loc_2);
            MailController.getInstance().changeToList();
            return;
        }// end function

        private function doDel(param1:Vector.<long>) : void
        {
            MailController.getInstance().delMail(0, param1);
            MailController.getInstance().changeToList();
            return;
        }// end function

        private function __pageChange(event:PageEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = MailController.getInstance();
            var _loc_3:* = _loc_2.curIndex;
            if (event.data.direct == -1)
            {
                _loc_3 = _loc_3 - 1;
                if ((_loc_3 + 1) % MailController.PAGESIZE == 0)
                {
                    _loc_4 = _loc_2.getPage(_loc_2.type);
                    if (--_loc_4 < 1)
                    {
                        --_loc_4 = 1;
                    }
                    _loc_2.pageChange(--_loc_4);
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                if (_loc_3 == _loc_2.curIndex && _loc_3 == 0)
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10906"));
                }
                else
                {
                    _loc_2.getInfoByIndex(_loc_3);
                }
            }
            else if (event.data.direct == 1)
            {
                if (_loc_2.type == 1 || _loc_2.type == 2)
                {
                    _loc_3++;
                    if (_loc_3 > (_loc_2.totalNum - 1))
                    {
                        _loc_3 = _loc_2.totalNum - 1;
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10907"));
                        return;
                    }
                }
                else if (_loc_2.type == 0)
                {
                    _loc_3 = _loc_2.curIndex;
                    if (_loc_2.unReadList.length > 0)
                    {
                        if (_loc_3 > (_loc_2.unReadList.length - 1))
                        {
                            _loc_2.unReadList.length = (_loc_2.unReadList.length - 1);
                            _loc_3 = _loc_2.unReadList.length - 1;
                            _loc_2.curIndex = _loc_2.unReadList.length - 1;
                        }
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10907"));
                        return;
                    }
                }
                if (_loc_3 % MailController.PAGESIZE == 0)
                {
                    _loc_4 = _loc_2.getPage(_loc_2.type);
                    _loc_4 = _loc_4 + 1;
                    _loc_2.pageChange(_loc_4);
                }
                _loc_2.getInfoByIndex(_loc_3);
            }
            return;
        }// end function

        private function __acceptClick(event:MouseEvent) : void
        {
            MailController.getInstance().isInfoGet = true;
            MailController.getInstance().getItem(this._info.mailid, long.fromNumber(-1));
            return;
        }// end function

    }
}
