package com.game.vipcopy.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.vipcopy.control.*;
    import com.game.vipcopy.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class VipEnterCopyView extends Component
    {
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var mc7:MovieClip;
        private var mc8:MovieClip;
        private var mc9:MovieClip;
        private var mc_boss:MovieClip;
        private var mc_boss2:MovieClip;
        private var mc_Img:MovieClip;
        private var mc_vip:MovieClip;
        private var _vipCopyNestDrop:VipCopyNestDrop;
        private var vipArray:Array;
        private var expArray:Array;
        private var copyIdArray:Array;
        private var goodsID:Array;
        private var curSelect:int = 1;
        private var _btnShowNest:BaseButton;
        private var _mcZoneLevel:MovieClip;
        private var isZoneMaxLevel:Boolean = false;

        public function VipEnterCopyView()
        {
            this.vipArray = [4, 5, 7];
            this.expArray = ["100000", "150000", "200000"];
            this.copyIdArray = [3007, 3008, 3009];
            this.goodsID = [];
            initComponentUI("enterCopyPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        public function get vipCopyNestDrop() : VipCopyNestDrop
        {
            return this._vipCopyNestDrop;
        }// end function

        private function initUI() : void
        {
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("11422"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("11423"));
            this._btnShowNest = new BaseButton(getDisplayChildByName("btnShowNest"));
            this._mcZoneLevel = MovieClip(getDisplayChildByName("mcZoneLevel"));
            var _loc_1:* = 0;
            while (_loc_1 < 9)
            {
                
                this["mc" + (_loc_1 + 1)] = getDisplayChildByName("mc" + (_loc_1 + 1));
                _loc_1++;
            }
            this.mc_boss = getDisplayChildByName("mc_boss");
            this.mc_boss2 = getDisplayChildByName("mc_boss2");
            this.mc_Img = getDisplayChildByName("mc_Img");
            this.mc_vip = getDisplayChildByName("mc_vip");
            this._vipCopyNestDrop = new VipCopyNestDrop(this);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this._btnShowNest.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            switch(event.target)
            {
                case this.btn1:
                {
                    if (UserObj.getInstance().playerInfo.vipid >= this.vipArray[(this.curSelect - 1)])
                    {
                        _loc_2 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[(this.curSelect - 1)]);
                        _loc_3 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.copyIdArray[(this.curSelect - 1)]);
                        _loc_4 = int(_loc_3.need_item);
                        if (_loc_4 == 0)
                        {
                            if (_loc_2 == 0)
                            {
                                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11424"));
                            }
                            else
                            {
                                VipCopyControl.getInstance().reqEnterVipCopy(0, this.copyIdArray[(this.curSelect - 1)]);
                            }
                            return;
                        }
                        VipCopyControl.getInstance().openVipCopySurePanel();
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11425"));
                    }
                    break;
                }
                case this.btn2:
                {
                    VipCopyControl.getInstance().openVipCopyBossBox();
                    this._vipCopyNestDrop.close();
                    break;
                }
                case this._btnShowNest:
                {
                    if (this.isZoneMaxLevel)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12413"));
                    }
                    else
                    {
                        this._vipCopyNestDrop.openOrClose();
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

        public function clear() : void
        {
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (UILoaded)
            {
                this.curSelect = VipCopyData.getInstance().curSelect;
                this.mc_vip.mc_count.gotoAndStop((this.vipArray[(this.curSelect - 1)] + 1));
                this.mc_boss.gotoAndStop(this.curSelect);
                this.mc_boss2.gotoAndStop(this.curSelect);
                _loc_1 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.copyIdArray[(this.curSelect - 1)]);
                this.goodsID = [];
                _loc_2 = String(_loc_1.reward).split("|");
                _loc_3 = UserObj.getInstance().playerInfo.level;
                _loc_4 = "";
                _loc_5 = 1;
                _loc_6 = 0;
                while (_loc_6 < _loc_2.length)
                {
                    
                    _loc_8 = String(_loc_2[_loc_6]).split("_");
                    if (_loc_8[0] <= _loc_3 && _loc_3 <= _loc_8[1])
                    {
                        _loc_4 = _loc_8[2];
                        _loc_5 = _loc_6 + 1;
                    }
                    _loc_6++;
                }
                if (_loc_5 == _loc_2.length)
                {
                    this.isZoneMaxLevel = true;
                }
                else
                {
                    this.isZoneMaxLevel = false;
                }
                this._mcZoneLevel.gotoAndStop((_loc_5 + 1));
                this.goodsID.push(int(_loc_1.first_reward));
                this.goodsID = this.goodsID.concat(_loc_4.split(";"));
                _loc_7 = 0;
                while (_loc_7 < 9)
                {
                    
                    _loc_9 = PropUtil.createItemByCfg(this.goodsID[_loc_7]);
                    _loc_10 = new IconItem("");
                    _loc_10.setWH(40, 40);
                    _loc_10.setImageSize(40, 40);
                    _loc_10.setInfo(_loc_9);
                    _loc_10.x = 5;
                    _loc_10.y = 5;
                    if (this["mc" + (_loc_7 + 1)].numChildren)
                    {
                        this["mc" + (_loc_7 + 1)].removeChildAt(0);
                    }
                    this["mc" + (_loc_7 + 1)].addChild(_loc_10);
                    _loc_7++;
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
