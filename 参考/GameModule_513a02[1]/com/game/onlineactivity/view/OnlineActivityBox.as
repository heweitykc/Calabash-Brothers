package com.game.onlineactivity.view
{
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.model.*;
    import com.game.onlineactivity.control.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OnlineActivityBox extends BaseBox
    {
        private var mc_List:MovieClip;
        private var _list:List;
        private var closeBtn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;
        private var btn7:BaseButton;
        private var btn_join:BaseButton;
        private var txt_des:TextField;
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var mc_bg:MovieClip;
        private var btn_page:MovieClip;
        private var btn_pre:BaseButton;
        private var btn_next:BaseButton;
        private var txt_page:TextField;
        private var curPage:int = 1;
        private var totalPage:int = 1;
        private const PAGE_NUM:int = 8;
        private var _type:int = 1;
        private var btnAry:Array;
        private var oldActivityId:Array;
        private var btnId:Array;
        private var curBtnId:Array;
        public static var activityId:Array = [10, 11, 12, 14, 13, 15, 34];
        public static var jumpUrl:Array = [];

        public function OnlineActivityBox()
        {
            this.btnAry = [];
            this.oldActivityId = [10, 11, 12, 14, 13, 15, 34];
            this.btnId = ["btn1", "btn2", "btn3", "btn4", "btn5", "btn6", "btn7"];
            this.curBtnId = [];
            loadDisplay("res/onlineactivity.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("onlineActivity");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(502, 208, null, "scrollBar2");
            this.mc_List.addChild(this._list);
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn6 = new BaseButton(getDisplayChildByName("btn6"));
            this.btn7 = new BaseButton(getDisplayChildByName("btn7"));
            this.btn1.name = "btn1";
            this.btn2.name = "btn2";
            this.btn3.name = "btn3";
            this.btn4.name = "btn4";
            this.btn5.name = "btn5";
            this.btn6.name = "btn6";
            this.btn6.name = "btn7";
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn5.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn6.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn7.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btnAry.push(this.btn1);
            this.btnAry.push(this.btn2);
            this.btnAry.push(this.btn3);
            this.btnAry.push(this.btn4);
            this.btnAry.push(this.btn5);
            this.btnAry.push(this.btn6);
            this.btn_join = new BaseButton(getDisplayChildByName("btn_join"));
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.txt3 = getDisplayChildByName("txt3");
            this.txt4 = getDisplayChildByName("txt4");
            this.mc_bg = getDisplayChildByName("mc_bg");
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn_pre = new BaseButton(this.btn_page.getChildByName("btn_left"));
            this.btn_next = new BaseButton(this.btn_page.getChildByName("btn_right"));
            this.txt_page = this.btn_page.getChildByName("txt_page") as TextField;
            this.txt_page.text = "1/1";
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_pre.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_next.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_join.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            NewActivityModel.getInstance().addEvtListener(NewActivityEvent.ACTIVITY_GROUP_ADD, this.updateBtn);
            NewActivityModel.getInstance().addEvtListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this.updateBtn);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.curBtnId.indexOf(event.target);
            if (this._type == (_loc_2 + 1))
            {
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.curBtnId.length)
            {
                
                if (this.curBtnId[_loc_3] == event.target)
                {
                    this.curBtnId[_loc_3].selected = true;
                }
                else
                {
                    this.curBtnId[_loc_3].selected = false;
                }
                _loc_3++;
            }
            this._type = _loc_2 + 1;
            this.updateContent(this._type);
            this.reqMessage();
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn_pre:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage - 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage < 1)
                    {
                        this.curPage = 1;
                    }
                    this.updatePage();
                    break;
                }
                case this.btn_next:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.curPage + 1;
                    _loc_2.curPage = _loc_3;
                    if (this.curPage > this.totalPage)
                    {
                        this.curPage = this.totalPage;
                    }
                    this.updatePage();
                    break;
                }
                case this.btn_join:
                {
                    if (jumpUrl[this._type])
                    {
                        ToolKit.gotoWeb(jumpUrl[this._type]);
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

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.updateActivity();
            if (UILoaded)
            {
                this.curPage = 1;
                this.update();
            }
            this.reqMessage();
            return;
        }// end function

        private function updateActivity() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_1:* = this.oldActivityId.slice();
            activityId = [];
            var _loc_2:* = NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_ONLINE_ACTIVITY);
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_1.indexOf(_loc_3);
                if (_loc_4 != -1)
                {
                    activityId.push(_loc_1[_loc_4]);
                }
            }
            return;
        }// end function

        private function reqMessage() : void
        {
            NewActivityModel.getInstance().getActivityByActivityId(activityId[(this._type - 1)]).addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.resMessage);
            OnlineActivityControl.getInstance().reqGetNewActivityInfo(activityId[(this._type - 1)]);
            return;
        }// end function

        private function resMessage(event:NewActivityEvent = null) : void
        {
            if (UILoaded)
            {
                this.updateContent(this._type);
            }
            return;
        }// end function

        private function update() : void
        {
            this.updateBtn();
            this.updateContent();
            return;
        }// end function

        private function updateBtn(event:NewActivityEvent = null) : void
        {
            var _loc_5:* = undefined;
            var _loc_6:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.btnAry.length)
            {
                
                this.btnAry[_loc_2].visible = false;
                _loc_2++;
            }
            this.curBtnId = [];
            var _loc_3:* = NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_ONLINE_ACTIVITY);
            var _loc_4:* = 0;
            for each (_loc_5 in _loc_3)
            {
                
                _loc_6 = this.oldActivityId.indexOf(_loc_5);
                if (_loc_6 != -1)
                {
                    this.curBtnId.push(this[this.btnId[_loc_6]]);
                    activityId.push(this.oldActivityId[_loc_6]);
                    _loc_4++;
                }
            }
            this.curBtnId.sortOn("name");
            this.totalPage = Math.ceil(_loc_4 / this.PAGE_NUM);
            this.totalPage = this.totalPage < 1 ? (1) : (this.totalPage);
            this.btn_page.visible = this.totalPage >= 2;
            this.updatePage();
            if (_loc_4 < 1)
            {
                MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_ONLINE);
            }
            return;
        }// end function

        private function updatePage() : void
        {
            var _loc_1:* = this.curBtnId.slice((this.curPage - 1) * this.PAGE_NUM, this.curPage * this.PAGE_NUM);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_1[_loc_2].visible = true;
                _loc_1[_loc_2].y = this.btn1.y + _loc_2 * (this.btn1.height + 2);
                _loc_2++;
            }
            this.txt_page.text = this.curPage + "/" + this.totalPage;
            if (_loc_1[0])
            {
                _loc_1[0].selected = true;
                _loc_1[0].dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        private function updateContent(param1:int = 1) : void
        {
            this._list.reset();
            var _loc_2:* = new OnlineDecItem();
            var _loc_3:* = new Object();
            _loc_3.type = param1;
            _loc_2.obj = _loc_3;
            this._list.add(_loc_2);
            this.mc_bg.gotoAndStop(param1);
            return;
        }// end function

    }
}
