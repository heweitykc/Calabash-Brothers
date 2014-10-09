package com.game.guild.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import flash.display.*;
    import flash.events.*;

    public class GuildEventView extends Component
    {
        private var btn_eventHistory:BaseButton;
        private var btn_submitHistory:BaseButton;
        private var btnArray:Array;
        private var mcArray:Array;
        private var funArray:Array;
        private var funArray2:Array;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc_List1:MovieClip;
        private var check_btn1:BaseButton;
        private var check_btn2:BaseButton;
        private var checkBtnArray:Array;
        private var mc_List2:MovieClip;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;
        private var btnStateArray:Array;
        private var btnStateNameArray:Array;
        private var sortAttrArray:Array;
        private var lastSortClick:int = -1;
        private var _sortType:String = "userName";
        private var _list1:List;
        private var _list2:List;
        private var _guildEventItem:GuildEventItem;
        private var _guildSubmitItem:GuildSubmitItem;

        public function GuildEventView()
        {
            this.btnArray = [];
            this.mcArray = [];
            this.funArray = [];
            this.funArray2 = [];
            this.checkBtnArray = [];
            this.btnStateArray = [];
            this.btnStateNameArray = [LanguageCfgObj.getInstance().getByIndex("12071"), LanguageCfgObj.getInstance().getByIndex("12059"), LanguageCfgObj.getInstance().getByIndex("12060"), LanguageCfgObj.getInstance().getByIndex("12061"), LanguageCfgObj.getInstance().getByIndex("12062"), LanguageCfgObj.getInstance().getByIndex("12063")];
            this.sortAttrArray = ["userName", "dragon", "whiteTiger", "suzaku", "basaltic", "stockGold"];
            initComponentUI("guildEventPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_eventHistory = new BaseButton(getDisplayChildByName("btn_eventHistory"), true);
            this.btn_eventHistory.setText(LanguageCfgObj.getInstance().getByIndex("10817"));
            this.btn_submitHistory = new BaseButton(getDisplayChildByName("btn_submitHistory"), true);
            this.btn_submitHistory.setText(LanguageCfgObj.getInstance().getByIndex("10818"));
            this.btnArray.push(this.btn_eventHistory, this.btn_submitHistory);
            this.mc1 = getDisplayChildByName("mc1");
            this.mc_List1 = this.mc1.getChildByName("mc_List") as MovieClip;
            this.check_btn1 = new BaseButton(this.mc1.getChildByName("check_btn1"), true);
            this.check_btn1.selected = false;
            this.check_btn1.setText(LanguageCfgObj.getInstance().getByIndex("10819"));
            this.check_btn2 = new BaseButton(this.mc1.getChildByName("check_btn2"), true);
            this.check_btn2.selected = false;
            this.check_btn2.setText(LanguageCfgObj.getInstance().getByIndex("10820"));
            this.checkBtnArray.push(this.check_btn1, this.check_btn2);
            this.mc2 = getDisplayChildByName("mc2");
            this.mc2.visible = false;
            this.mc_List2 = this.mc2.getChildByName("mc_List") as MovieClip;
            this.btn1 = new BaseButton(this.mc2.getChildByName("btn1"));
            this.btn2 = new BaseButton(this.mc2.getChildByName("btn2"));
            this.btn3 = new BaseButton(this.mc2.getChildByName("btn3"));
            this.btn4 = new BaseButton(this.mc2.getChildByName("btn4"));
            this.btn5 = new BaseButton(this.mc2.getChildByName("btn5"));
            this.btn6 = new BaseButton(this.mc2.getChildByName("btn6"));
            this.btnStateArray.push(this.btn1, this.btn2, this.btn3, this.btn4, this.btn5, this.btn6);
            var _loc_1:* = 0;
            while (_loc_1 < this.btnStateArray.length)
            {
                
                this.btnStateArray[_loc_1].setText(this.btnStateNameArray[_loc_1]);
                _loc_1++;
            }
            this.mcArray.push(this.mc1, this.mc2);
            this.funArray.push(this.updateTotal, this.updateMc2);
            this.funArray2.push(this.updateTotal, this.updateInOut);
            this._list1 = new List(695, 360);
            this._list2 = new List(569, 375);
            this.mc_List1.addChild(this._list1);
            this.mc_List2.addChild(this._list2);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_eventHistory.addEventListener(MouseEvent.CLICK, this.__click1, false, 0, true);
            this.btn_submitHistory.addEventListener(MouseEvent.CLICK, this.__click1, false, 0, true);
            this.check_btn1.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.check_btn2.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            var _loc_1:* = 0;
            while (_loc_1 < this.btnStateArray.length)
            {
                
                this.btnStateArray[_loc_1].addEventListener(MouseEvent.CLICK, this.__click3, false, 0, true);
                _loc_1++;
            }
            GuildData.getInstance().addEvtListener(GuildEvent.EVENTLIST_CHANGE, this.updateTotal);
            return;
        }// end function

        private function __click1(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnArray.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.btnArray.length)
            {
                
                if (this.btnArray[_loc_3] == event.target)
                {
                    this.btnArray[_loc_3].selected = true;
                    this.mcArray[_loc_3].visible = true;
                    this.funArray[_loc_3].call();
                }
                else
                {
                    this.btnArray[_loc_3].selected = false;
                    this.mcArray[_loc_3].visible = false;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.checkBtnArray.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.checkBtnArray.length)
            {
                
                if (this.checkBtnArray[_loc_3] == event.target)
                {
                    this.checkBtnArray[_loc_3].selected = true;
                    this.funArray2[_loc_3].call();
                }
                else
                {
                    this.checkBtnArray[_loc_3].selected = false;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function __click3(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnStateArray.indexOf(event.target);
            if (this.lastSortClick == _loc_2)
            {
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.btnStateArray.length)
            {
                
                if (this.btnStateArray[_loc_3] == event.target)
                {
                    this.btnStateArray[_loc_3].selected = true;
                    this.sort(this.sortAttrArray[_loc_3]);
                }
                else
                {
                    this.btnStateArray[_loc_3].selected = false;
                }
                _loc_3++;
            }
            this.lastSortClick = _loc_2;
            return;
        }// end function

        private function sort(param1:String) : void
        {
            this._sortType = param1;
            return;
        }// end function

        public function update() : void
        {
            this.updateUI();
            this.btn_eventHistory.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function updateUI() : void
        {
            this.check_btn1.selected = true;
            this.check_btn2.selected = false;
            return;
        }// end function

        private function updateMc1(event:GuildEvent = null) : void
        {
            var _loc_3:* = 0;
            this._list1.reset();
            var _loc_2:* = GuildData.getInstance().eventList;
            if (_loc_2)
            {
                _loc_3 = _loc_2.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (_loc_2[_loc_3].messageType != LanguageCfgObj.getInstance().getByIndex("10821"))
                    {
                        this._guildEventItem = new GuildEventItem();
                        this._guildEventItem.obj = _loc_2[_loc_3];
                        this._list1.add(this._guildEventItem);
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        private function updateMc2Old() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            this._list2.reset();
            var _loc_1:* = GuildData.getInstance().eventList;
            var _loc_2:* = new Object();
            if (_loc_1)
            {
                _loc_6 = _loc_1.length - 1;
                while (_loc_6 >= 0)
                {
                    
                    if (_loc_1[_loc_6].messageType == LanguageCfgObj.getInstance().getByIndex("10822"))
                    {
                        _loc_7 = _loc_1[_loc_6].message;
                        _loc_8 = new Object();
                        _loc_9 = _loc_7.split(",");
                        _loc_8.name = _loc_9[0].substring(16, (_loc_9[0].length - 1));
                        _loc_8.number1 = uint(_loc_9[1].substring(11, _loc_9[1].length));
                        _loc_8.number2 = uint(_loc_9[2]);
                        _loc_8.number3 = uint(_loc_9[3]);
                        _loc_8.number4 = uint(_loc_9[4]);
                        _loc_8.number5 = uint(_loc_9[5].substring(0, _loc_9[5].length - 2));
                        if (_loc_2[_loc_8.name])
                        {
                            _loc_2[_loc_8.name].number1 = _loc_2[_loc_8.name].number1 + _loc_8.number1;
                            _loc_2[_loc_8.name].number2 = _loc_2[_loc_8.name].number2 + _loc_8.number2;
                            _loc_2[_loc_8.name].number3 = _loc_2[_loc_8.name].number3 + _loc_8.number3;
                            _loc_2[_loc_8.name].number4 = _loc_2[_loc_8.name].number4 + _loc_8.number4;
                            _loc_10 = uint(_loc_2[_loc_8.name].number5) + _loc_8.number5;
                            _loc_2[_loc_8.name].number5 = _loc_10.toString();
                        }
                        else
                        {
                            _loc_2[_loc_8.name] = _loc_8;
                        }
                    }
                    _loc_6 = _loc_6 - 1;
                }
            }
            _loc_9 = [];
            for each (_loc_3 in _loc_2)
            {
                
                _loc_9.push(_loc_3);
            }
            _loc_9.sortOn("number5", Array.DESCENDING | Array.NUMERIC);
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_9.length)
            {
                
                this._guildSubmitItem = new GuildSubmitItem();
                this._guildSubmitItem.index = _loc_5;
                if (_loc_5 == 0)
                {
                    this._guildSubmitItem.setGoldVisible();
                }
                this._guildSubmitItem.obj = _loc_9[_loc_5];
                this._list2.add(this._guildSubmitItem);
                _loc_5++;
            }
            return;
        }// end function

        private function updateMc2() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._list2.reset();
            var _loc_1:* = GuildData.getInstance().contributionList;
            if (_loc_1)
            {
                _loc_2 = _loc_1.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = new GuildSubmitItem();
                    _loc_3.obj = _loc_1[_loc_2];
                    this._list2.add(_loc_3);
                    _loc_2 = _loc_2 - 1;
                }
            }
            return;
        }// end function

        private function updateTotal(event:GuildEvent = null) : void
        {
            var _loc_3:* = 0;
            this._list1.reset();
            var _loc_2:* = GuildData.getInstance().eventList;
            if (_loc_2)
            {
                _loc_3 = _loc_2.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (_loc_2[_loc_3].messageType != "成员击败BOSS" && _loc_2[_loc_3].messageType != "成员被其他玩家击败")
                    {
                        this._guildEventItem = new GuildEventItem();
                        this._guildEventItem.obj = _loc_2[_loc_3];
                        this._list1.add(this._guildEventItem);
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        private function updateInOut(event:GuildEvent = null) : void
        {
            var _loc_3:* = 0;
            this._list1.reset();
            var _loc_2:* = GuildData.getInstance().eventList;
            if (_loc_2)
            {
                _loc_3 = _loc_2.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    if (_loc_2[_loc_3].messageType == "逐出成员" || _loc_2[_loc_3].messageType == "添加成员" || _loc_2[_loc_3].messageType == "退出战盟")
                    {
                        this._guildEventItem = new GuildEventItem();
                        this._guildEventItem.obj = _loc_2[_loc_3];
                        this._list1.add(this._guildEventItem);
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
