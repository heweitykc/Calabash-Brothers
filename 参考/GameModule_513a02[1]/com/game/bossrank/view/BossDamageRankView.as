package com.game.bossrank.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.game.bossrank.events.*;
    import com.game.bossrank.model.*;
    import com.game.monster.bean.*;
    import com.game.task.view.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BossDamageRankView extends Component
    {
        private var mc_info:MovieClip;
        private var txt_bossname:TextField;
        private var txt_nodamage:TextField;
        private var btn_rule:BaseButton;
        public var btn_down:BaseButton;
        public var btn_up:BaseButton;
        public var mc_tips:MovieClip;
        public var mc_mytips:MovieClip;
        private var mc_List:MovieClip;
        private var _list:List;
        private var mc_myrank:MovieClip;
        private var _bossDamageRankItem:BossDamageRankItem;
        private var _myInfos:CaptainDamageInfo = null;
        private var _type:Object = 1;
        public static const TITLE_HEIGHT:int = 27;

        public function BossDamageRankView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/bossdamagerank.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("bossDamageRank");
            this.initUI();
            this.addEvents();
            this.open(this._type);
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_info = getDisplayChildByName("mc_info");
            this.txt_bossname = getDisplayChildByName("txt_bossname");
            this.btn_rule = new BaseButton(getDisplayChildByName("btn_rule"));
            StringTip.create(this.btn_rule, LanguageCfgObj.getInstance().getByIndex("10007", "lang_island"));
            this.btn_down = new BaseButton(getDisplayChildByName("btn_down"));
            this.btn_up = new BaseButton(getDisplayChildByName("btn_up"));
            this.btn_down.visible = false;
            this.mc_tips = this.mc_info.getChildByName("mc_tips") as MovieClip;
            this.mc_tips.visible = false;
            StringTip.create(this.mc_tips, LanguageCfgObj.getInstance().getByIndex("10008", "lang_island"));
            this.mc_mytips = this.mc_info.getChildByName("mc_mytips") as MovieClip;
            this.mc_mytips.visible = false;
            StringTip.create(this.mc_mytips, LanguageCfgObj.getInstance().getByIndex("10008", "lang_island"));
            this.mc_myrank = this.mc_info.getChildByName("mc_myrank") as MovieClip;
            this.txt_nodamage = this.mc_info.getChildByName("txt_nodamage") as TextField;
            this.txt_nodamage.visible = false;
            this.mc_List = this.mc_info.getChildByName("mc_List") as MovieClip;
            this._list = new List(250, 115);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_down.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.btn_up.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.btn_rule.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.mc_myrank.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
            this.mc_myrank.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
            FrameworkGlobal.addMsgListen("bossinfo_open", this.__bossinfoOpen);
            FrameworkGlobal.addMsgListen("bossinfo_close", this.__bossinfoClose);
            BossDamageData.getInstance().addEvtListener(BossDamageEvent.BOSS_DAMAGE_DATA_CHANGE, this.update);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn_down:
                {
                    this.btn_down.visible = false;
                    this.btn_up.visible = true;
                    this.mc_info.visible = true;
                    if (ZonesControl.getInstance().inBossHome())
                    {
                    }
                    else if (this.parent)
                    {
                        this.y = -this.height;
                        FrameworkGlobal.sendMsg(new Event("task_close"));
                        Global.mainUIManager.addUI(this.parent as BaseSprite, new LayoutInfo(Layout.RIGHT, 0, 155 + this.height), GroupPanelType.GROUP_LEVEL1);
                    }
                    break;
                }
                case this.btn_up:
                {
                    this.btn_down.visible = true;
                    this.btn_up.visible = false;
                    this.mc_info.visible = false;
                    if (ZonesControl.getInstance().inBossHome())
                    {
                    }
                    else if (this.parent)
                    {
                        this.y = -TITLE_HEIGHT;
                        FrameworkGlobal.sendMsg(new Event("task_open"));
                        Global.mainUIManager.addUI(this.parent as BaseSprite, new LayoutInfo(Layout.RIGHT, 0, 155 + TITLE_HEIGHT), GroupPanelType.GROUP_LEVEL1);
                    }
                    break;
                }
                case this.btn_rule:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __bossinfoClose(event:Event) : void
        {
            this.btn_down.visible = true;
            this.btn_up.visible = false;
            this.mc_info.visible = false;
            return;
        }// end function

        private function __bossinfoOpen(event:Event) : void
        {
            this.btn_down.visible = false;
            this.btn_up.visible = true;
            this.mc_info.visible = true;
            return;
        }// end function

        public function update(event:BossDamageEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (!this.parent)
            {
                return;
            }
            if (UILoaded)
            {
                this._list.reset();
                this.mc_tips.visible = false;
                _loc_2 = BossDamageData.getInstance().damageInfos;
                if (_loc_2 && _loc_2.length)
                {
                    this.mc_tips.visible = true;
                }
                this._myInfos = null;
                _loc_3 = -1;
                _loc_4 = 0;
                while (_loc_2 && _loc_4 < _loc_2.length)
                {
                    
                    this._bossDamageRankItem = new BossDamageRankItem();
                    this._bossDamageRankItem.index = _loc_4 + 1;
                    this._bossDamageRankItem.obj = _loc_2[_loc_4];
                    this._list.add(this._bossDamageRankItem);
                    _loc_2[_loc_4].teamInfo.sort(this.compare);
                    _loc_6 = 0;
                    while (_loc_6 < _loc_2[_loc_4].teamInfo.length)
                    {
                        
                        _loc_7 = _loc_2[_loc_4].teamInfo[_loc_6];
                        if (_loc_7.memberName == UserObj.getInstance().playerInfo.name)
                        {
                            this._myInfos = _loc_2[_loc_4];
                            _loc_3 = _loc_4 + 1;
                            break;
                        }
                        _loc_6++;
                    }
                    _loc_4++;
                }
                if (this._myInfos)
                {
                    this.mc_myrank.visible = true;
                    this.mc_myrank.txt1.text = _loc_3.toString();
                    this.mc_myrank.txt2.text = this._myInfos.captainName;
                    this.mc_myrank.txt3.text = this._myInfos.damage.toString();
                    this.mc_myrank.mc_box.visible = _loc_3 == 1;
                    this.txt_nodamage.visible = false;
                    this.mc_mytips.visible = _loc_3 == 1;
                }
                else
                {
                    this.mc_myrank.visible = false;
                    this.mc_mytips.visible = false;
                    this.txt_nodamage.visible = true;
                }
                _loc_5 = RoleList.getInstance().getRole(BossDamageData.getInstance().monsterId);
                if (_loc_5)
                {
                    this.txt_bossname.text = "" + _loc_5.info.name;
                }
                else
                {
                    this.txt_bossname.text = LanguageCfgObj.getInstance().getByIndex("10009", "lang_island");
                }
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._myInfos)
            {
                _loc_2 = BossDamageRankItem.bossInfoTipsView;
                _loc_2.update(this._myInfos.teamInfo);
                _loc_3 = localToGlobal(new Point(this.mc_myrank.x, this.mc_myrank.y));
                _loc_2.x = _loc_3.x - 20;
                _loc_2.y = _loc_3.y + 50;
                FrameworkGlobal.stage.addChild(_loc_2);
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            var _loc_2:* = BossDamageRankItem.bossInfoTipsView;
            if (_loc_2.parent)
            {
                _loc_2.parent.removeChild(_loc_2);
            }
            return;
        }// end function

        private function compare(param1:TeamMemberDamage, param2:TeamMemberDamage) : int
        {
            if (param1.damage < param2.damage)
            {
                return 1;
            }
            if (param1.damage > param2.damage)
            {
                return -1;
            }
            return 0;
        }// end function

        public function open(param1:int = 1) : void
        {
            if (!UILoaded)
            {
                this._type = param1;
                return;
            }
            var _loc_2:* = FastTaskPanel.getInstance();
            if (param1 == 1)
            {
                _loc_2.addChild(this);
                this.x = 0;
                this.y = -TITLE_HEIGHT;
                FrameworkGlobal.sendMsg(new Event("bossinfo_close"));
                FrameworkGlobal.sendMsg(new Event("task_open"));
                Global.mainUIManager.addUI(this.parent as BaseSprite, new LayoutInfo(Layout.RIGHT, 0, 155 + TITLE_HEIGHT), GroupPanelType.GROUP_LEVEL1);
            }
            else if (param1 == 2)
            {
                _loc_2.addChild(this);
                this.x = 0;
                this.y = -height;
                FrameworkGlobal.sendMsg(new Event("bossinfo_open"));
                FrameworkGlobal.sendMsg(new Event("task_close"));
                Global.mainUIManager.addUI(this.parent as BaseSprite, new LayoutInfo(Layout.RIGHT, 0, 155 + height), GroupPanelType.GROUP_LEVEL1);
            }
            else if (param1 == 3)
            {
                this.btn_down.visible = false;
                this.btn_up.visible = true;
                this.mc_info.visible = true;
                Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 155), GroupPanelType.GROUP_LEVEL1);
            }
            this.update();
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:* = FastTaskPanel.getInstance();
            if (parent)
            {
                parent.removeChild(this);
                if (ZonesControl.getInstance().inBossHome())
                {
                }
                else
                {
                    if (_loc_1.btn_down)
                    {
                        _loc_1.btn_down.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    }
                    Global.mainUIManager.addUI(_loc_1, new LayoutInfo(Layout.RIGHT, 0, 155), GroupPanelType.GROUP_LEVEL1);
                }
            }
            return;
        }// end function

    }
}
