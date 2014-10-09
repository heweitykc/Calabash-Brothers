package com.game.guild.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.game.guild.bean.*;
    import com.game.guild.control.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildListView extends Component
    {
        private var mc_List:MovieClip;
        private var _list:List;
        private var _guildApplyItem:GuildApplyItem;
        private var _guildList:Vector.<GuildInfo>;
        private var _curSelectItem:GuildApplyItem;
        private var check_btn1:BaseButton;
        private var check_btn2:BaseButton;
        private var check_btn3:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;
        private var btn_apply1:BaseButton;
        private var btn_apply2:BaseButton;
        private var txt_searchGood:TextField;
        private var btn_search:BaseButton;
        private var btn_page:MovieClip;
        private var btn_pre:BaseButton;
        private var btn_next:BaseButton;
        private var txt_page:TextField;
        public var pageNum:int = 20;
        private var _sortType:String = "guildName";
        public static var curPage:int = 1;
        public static var totalPage:int = 1;

        public function GuildListView()
        {
            initComponentUI("guildApplyPanel2");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(714, 340);
            this.mc_List.addChild(this._list);
            this.check_btn1 = new BaseButton(getDisplayChildByName("check_btn1"), true);
            this.check_btn1.selected = false;
            this.check_btn1.setText(LanguageCfgObj.getInstance().getByIndex("10833"));
            this.check_btn2 = new BaseButton(getDisplayChildByName("check_btn2"), true);
            this.check_btn2.selected = false;
            this.check_btn2.setText(LanguageCfgObj.getInstance().getByIndex("10834"));
            this.check_btn3 = new BaseButton(getDisplayChildByName("check_btn3"), true);
            this.check_btn3.selected = false;
            this.check_btn3.setText(LanguageCfgObj.getInstance().getByIndex("10835"));
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn6 = new BaseButton(getDisplayChildByName("btn6"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10836"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10837"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10838"));
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("10839"));
            this.btn5.setText(LanguageCfgObj.getInstance().getByIndex("10840"));
            this.btn6.setText(LanguageCfgObj.getInstance().getByIndex("10841"));
            StringTip.create(this.btn2, LanguageCfgObj.getInstance().getByIndex("10842"));
            StringTip.create(this.btn3, LanguageCfgObj.getInstance().getByIndex("10843"));
            StringTip.create(this.btn4, LanguageCfgObj.getInstance().getByIndex("10844"));
            StringTip.create(this.btn5, LanguageCfgObj.getInstance().getByIndex("10845"));
            StringTip.create(this.btn6, LanguageCfgObj.getInstance().getByIndex("10846"));
            this.btn_apply1 = new BaseButton(getDisplayChildByName("btn_apply1"), true);
            this.btn_apply2 = new BaseButton(getDisplayChildByName("btn_apply2"), true);
            this.btn_apply1.setText(LanguageCfgObj.getInstance().getByIndex("10847"));
            this.btn_apply2.setText(LanguageCfgObj.getInstance().getByIndex("10848"));
            this.check_btn1.visible = false;
            this.btn_apply1.visible = false;
            this.btn_apply2.visible = false;
            this.btn_page = getDisplayChildByName("btn_page");
            this.btn_pre = new BaseButton(this.btn_page.getChildByName("btn_pre"));
            this.btn_next = new BaseButton(this.btn_page.getChildByName("btn_next"));
            this.txt_page = this.btn_page.getChildByName("txt_page") as TextField;
            this.txt_page.text = "1/1";
            this.txt_searchGood = getDisplayChildByName("txt_searchGood");
            this.btn_search = new BaseButton(getDisplayChildByName("btn_search"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.check_btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn4.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn5.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn6.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_apply1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_apply2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_search.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.txt_searchGood.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this.txt_searchGood.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            this.txt_searchGood.addEventListener(Event.CHANGE, this.textChangeHanler);
            this.txt_searchGood.addEventListener(MouseEvent.CLICK, this.focusInHanler, false, 0, true);
            this.btn_pre.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_next.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            GuildData.getInstance().addEvtListener(GuildEvent.GUILDLIST_CHANGE, this.resData);
            return;
        }// end function

        private function focusInHanler(event:Event) : void
        {
            switch(event.target)
            {
                case this.txt_searchGood:
                {
                    if (event.target.text == LanguageCfgObj.getInstance().getByIndex("12414"))
                    {
                        event.target.text = "";
                    }
                    this.txt_searchGood.textColor = 16769175;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function focusOutHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_searchGood:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = LanguageCfgObj.getInstance().getByIndex("12414");
                        this.txt_searchGood.textColor = 8417369;
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

        private function textChangeHanler(event:Event) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.txt_searchGood:
                {
                    if (event.target.text == "")
                    {
                        GuildControl.getInstance().reqGuildList();
                    }
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12414");
                    if (event.target.text.search(_loc_2) != -1)
                    {
                        event.target.text = event.target.text.replace(_loc_2, "");
                        this.txt_searchGood.textColor = 16769175;
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

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.check_btn1:
                {
                    break;
                }
                case this.check_btn2:
                {
                    this.filterOnlineAndAutoAgree();
                    break;
                }
                case this.check_btn3:
                {
                    this.filterOnlineAndAutoAgree();
                    break;
                }
                case this.btn2:
                {
                    this.sort("guildName");
                    break;
                }
                case this.btn3:
                {
                    this.sort("bangZhuName");
                    break;
                }
                case this.btn4:
                {
                    this.sort("bannerLevel");
                    break;
                }
                case this.btn5:
                {
                    this.sort("memberNum");
                    break;
                }
                case this.btn6:
                {
                    this.sort("memberFightPower");
                    break;
                }
                case this.btn_apply1:
                {
                    GuildControl.getInstance().guildCreatBox.btnCreat.dispatchEvent(new MouseEvent("click"));
                    break;
                }
                case this.btn_apply2:
                {
                    if (!this._curSelectItem)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10849"));
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("12080") + this._curSelectItem.info.guildName);
                        GuildControl.getInstance().reqGuildApplyAdd(this._curSelectItem.info.guildId);
                    }
                    break;
                }
                case this.btn_search:
                {
                    this.searchGuild();
                    break;
                }
                case this.btn_pre:
                {
                    if (totalPage == 1)
                    {
                        return;
                    }
                    var _loc_3:* = curPage - 1;
                    curPage = _loc_3;
                    if (curPage < 1)
                    {
                        curPage = totalPage;
                    }
                    this.txt_page.text = curPage + "/" + totalPage;
                    this.reqData();
                    break;
                }
                case this.btn_next:
                {
                    if (totalPage == 1)
                    {
                        return;
                    }
                    var _loc_3:* = curPage + 1;
                    curPage = _loc_3;
                    if (curPage > totalPage)
                    {
                        curPage = 1;
                    }
                    this.txt_page.text = curPage + "/" + totalPage;
                    this.reqData();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function reqData() : void
        {
            GuildControl.getInstance().reqGuildList(1, curPage);
            return;
        }// end function

        private function resData(event:GuildEvent) : void
        {
            this.update();
            this.sort("memberFightPower");
            return;
        }// end function

        private function filterOnlineAndAutoAgree() : void
        {
            if (this.check_btn2.selected && this.check_btn3.selected)
            {
                this._guildList = GuildData.getInstance().guildList.filter(this.callback1);
            }
            else if (this.check_btn2.selected)
            {
                this._guildList = GuildData.getInstance().guildList.filter(this.callback2);
            }
            else if (this.check_btn3.selected)
            {
                this._guildList = GuildData.getInstance().guildList.filter(this.callback3);
            }
            else
            {
                this._guildList = GuildData.getInstance().guildList;
            }
            this.refreshGuildList();
            return;
        }// end function

        private function callback1(param1, param2:int, param3:Vector.<GuildInfo>) : Boolean
        {
            if ((param1.bangZhuOnline || param1.viceBangZhuOnline) && param1.autoGuildAgreeAdd)
            {
                return true;
            }
            return false;
        }// end function

        private function callback2(param1, param2:int, param3:Vector.<GuildInfo>) : Boolean
        {
            if (param1.bangZhuOnline || param1.viceBangZhuOnline)
            {
                return true;
            }
            return false;
        }// end function

        private function callback3(param1, param2:int, param3:Vector.<GuildInfo>) : Boolean
        {
            if (param1.autoGuildAgreeAdd)
            {
                return true;
            }
            return false;
        }// end function

        private function sort(param1:String) : void
        {
            this._sortType = param1;
            this._guildList.sort(this.compare);
            this.update();
            return;
        }// end function

        private function compare(param1:GuildInfo, param2:GuildInfo) : int
        {
            if (param1[this._sortType] < param2[this._sortType])
            {
                return 1;
            }
            if (param1[this._sortType] > param2[this._sortType])
            {
                return -1;
            }
            return 0;
        }// end function

        public function update(event:GuildEvent = null) : void
        {
            if (this.parent == null)
            {
                return;
            }
            this.getData();
            if (this._guildList == null)
            {
                return;
            }
            this.refreshGuildList();
            this.filterOnlineAndAutoAgree();
            return;
        }// end function

        private function getData() : void
        {
            this._guildList = GuildData.getInstance().guildList;
            return;
        }// end function

        private function refreshGuildList() : void
        {
            this.txt_page.text = curPage + "/" + totalPage;
            this._list.reset();
            var _loc_1:* = 0;
            while (_loc_1 < this._guildList.length)
            {
                
                this._guildApplyItem = new GuildApplyItem();
                this._guildApplyItem.addEventListener(MouseEvent.CLICK, this.__selectItem);
                this._guildApplyItem.index = _loc_1 + (curPage - 1) * this.pageNum;
                if (_loc_1 == 0)
                {
                    this._guildApplyItem.selected = true;
                    this._curSelectItem = this._guildApplyItem;
                }
                else
                {
                    this._guildApplyItem.selected = false;
                }
                this._guildApplyItem.obj = this._guildList[_loc_1];
                this._list.add(this._guildApplyItem);
                _loc_1++;
            }
            return;
        }// end function

        public function __selectItem(event:MouseEvent = null) : void
        {
            if (this._curSelectItem)
            {
                this._curSelectItem.selected = false;
            }
            this._curSelectItem = event.currentTarget as GuildApplyItem;
            event.currentTarget.selected = true;
            return;
        }// end function

        private function searchGuild() : void
        {
            curPage = 1;
            var _loc_1:* = this.txt_searchGood.text;
            if (_loc_1 != LanguageCfgObj.getInstance().getByIndex("12414") && _loc_1 != "")
            {
                GuildControl.getInstance().reqGuildList(2, -1, this.txt_searchGood.text);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12416"));
            }
            return;
        }// end function

        public function clear() : void
        {
            if (UILoaded)
            {
                this.txt_searchGood.text = LanguageCfgObj.getInstance().getByIndex("12414");
                this.txt_searchGood.textColor = 8417369;
            }
            return;
        }// end function

    }
}
