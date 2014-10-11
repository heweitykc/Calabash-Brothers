package com.game.equipstreng.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.f1.vmc.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.equip.bean.*;
    import com.game.equipstreng.cfg.*;
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.events.*;
    import com.game.equipstreng.model.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.player.model.*;
    import com.game.prompt.utils.*;
    import com.game.protect.control.*;
    import com.game.sound.control.*;
    import com.game.vip.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class EquipStrengView extends Component
    {
        private var _equipInfo:EquipmentInfo;
        private var _lastStrengEquipInfo:EquipmentInfo;
        private var _lastProcessEquipInfo:EquipmentInfo;
        private var _listItem:EquipSelectItem;
        private var _list:List;
        private var _type:int = 1;
        private var _lastItem:EquipSelectItem;
        private var _op:int = 0;
        private var scoreTitle:TextField;
        private var mc_List:MovieClip;
        private var mc_effect:MovieClip;
        private var mc_effectFire:MovieClip;
        private var mc_effectFireProcess:MovieClip;
        private var fireMC:MovieClip;
        private var fireMC2:MovieClip;
        private var fire:MovieClip;
        private var fireMcArray:Array;
        private var fireMcArray2:Array;
        private var txt_label:TextField;
        private var mc_CurEquip:MovieClip;
        private var mc_PreEquip:MovieClip;
        private var txt_material:TextField;
        private var txt_materialValue:TextField;
        private var text_preview:TextField;
        private var txt_needMoney:TextField;
        private var mc_diamond:MovieClip;
        private var mc_successRate:MovieClip;
        private var img_successRate:ImgNumber;
        private var mc_bgSuccess:MovieClip;
        private var btn_streng:BaseButton;
        private var btn_successStreng:BaseButton;
        private var tipsImg:MovieClip;
        private var btn_rate:BaseButton;
        private var btn_backRate:BaseButton;
        private var btn_StartSplit:BaseButton;
        private var txt_SuitSplitCost:TextField;
        private var txt_SplitEquip1:TextField;
        private var txt_SplitEquip2:TextField;
        private var txt_SplitStone1:TextField;
        private var txt_SplitStone2:TextField;
        private var luckPanel:MovieClip;
        private var suitPanel:SuitPanel;
        private var scorePanel:ScorePanel;
        private var levelReviewPanel:LevelReviewPanel;
        private var attributeDetailPanel:AttributeDetailPanel;
        private var suitSplitView:MovieClip;
        private var suitSplitHit:EquipSuitSplitHit;
        private var txt_matrial1:TextField;
        private var txt_matrial2:TextField;
        private var txt_matrial3:TextField;
        private var txt_bagMatrial1:TextField;
        private var txt_bagMatrial2:TextField;
        private var txt_bagMatrial3:TextField;
        private var txt_bagMatrialNumber1:TextField;
        private var txt_bagMatrialNumber2:TextField;
        private var txt_bagMatrialNumber3:TextField;
        private var txt_needMoneyValue:TextField;
        private var baoshi1:MovieClip;
        private var baoshi2:MovieClip;
        private var baoshi3:MovieClip;
        private var _baoshiEquip1:EquipImage;
        private var _baoshiEquip2:EquipImage;
        private var _baoshiEquip3:EquipImage;
        private var txt_name1:TextField;
        private var txt_name2:TextField;
        private var txt_name3:TextField;
        private var check_btn:BaseButton;
        private var _curImage:EquipImage;
        private var _preImage:EquipImage;
        private var _videoContainer:VideoContainer;
        private var _videoFireContainer:VideoContainer;
        private var _videoContainerProcess:VideoContainer;
        private var _videoFireContainerProcess:VideoContainer;
        private var _videoLevelFireVmcView:VMCView;
        private var _videoLevelFireVmcView2:VMCView;
        private var _fireVmcArray:Array;
        private var _fireVmcArray2:Array;
        private var tipsImage:Image;
        private var _hasInitUI:Boolean = false;
        private var vipState:int = 1;
        private var _selectVmcView:VMCView;
        private var _isPlayingEffect:Boolean;
        private var hasOpenTips1:Boolean = false;
        private var hasOpenTips2:Boolean = false;
        private var hasOpenTips3:Boolean = false;
        private var hasOpenTips4:Boolean = false;
        private var hasOpenTipsDay1:Boolean = false;
        private var hasOpenTipsDay2:Boolean = false;
        private var hasOpenTipsDay3:Boolean = false;
        private var hasOpenTipsDay4:Boolean = false;
        private var hasOpenTipsDiamond:Boolean = false;
        private var hasOpenTipsDiamondDay:Boolean = false;
        public static const STRENGTH1_OP:int = 1;
        public static const PROCESS1_OP:int = 2;
        public static const STRENGTH2_OP:int = 3;
        public static const PROCESS2_OP:int = 4;
        public static const VIP_STRENGTH_OP:int = 5;
        public static const VIP_PROCESS_OP:int = 6;
        public static const LUCK_ADD_OP:int = 7;
        public static const TRANS_SUIT_OP:int = 8;
        public static const STRENGTH_SUIT_OP:int = 9;

        public function EquipStrengView()
        {
            this.fireMcArray = [];
            this.fireMcArray2 = [];
            this._fireVmcArray = [];
            this._fireVmcArray2 = [];
            loadDisplay("res/equipForge.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("equipStrengView");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(194, 402);
            this.mc_List.addChild(this._list);
            this.mc_effect = getDisplayChildByName("bg");
            this.mc_effectFire = getDisplayChildByName("mc_effectFire");
            this.mc_effectFireProcess = getDisplayChildByName("mc_effectFireProcess");
            this.fireMC = this.mc_effect.getChildByName("fireMC") as MovieClip;
            this.fireMC2 = this.mc_effect.getChildByName("fireMC2") as MovieClip;
            var _loc_1:* = 0;
            while (_loc_1 < 16)
            {
                
                this.fire = this.fireMC.getChildByName("fire" + (_loc_1 + 1)) as MovieClip;
                this.fireMcArray.push(this.fire);
                this.fire = this.fireMC2.getChildByName("fire" + (_loc_1 + 1)) as MovieClip;
                this.fireMcArray2.push(this.fire);
                _loc_1++;
            }
            this.scoreTitle = getDisplayChildByName("scoreTitle");
            this.scorePanel = new ScorePanel(getDisplayChildByName("scorePanel"));
            this.levelReviewPanel = new LevelReviewPanel(getDisplayChildByName("levelReviewPanel"));
            this.attributeDetailPanel = new AttributeDetailPanel(getDisplayChildByName("attributeDetailPanel"));
            this.txt_label = getDisplayChildByName("txt_label");
            this.mc_CurEquip = getDisplayChildByName("mc_CurEquip");
            this.mc_PreEquip = getDisplayChildByName("mc_PreEquip");
            this.txt_material = getDisplayChildByName("txt_material");
            this.txt_materialValue = getDisplayChildByName("txt_materialValue");
            this.text_preview = getDisplayChildByName("text_preview");
            this.txt_needMoney = getDisplayChildByName("txt_needMoney");
            this.mc_diamond = getDisplayChildByName("mc_diamond");
            this.mc_successRate = getDisplayChildByName("mc_successRate");
            this.img_successRate = new ImgNumber();
            this.mc_successRate.addChild(this.img_successRate);
            this.mc_bgSuccess = getDisplayChildByName("mc_bgSuccess");
            this.btn_streng = new BaseButton(getDisplayChildByName("btn_streng"));
            this.btn_successStreng = new BaseButton(getDisplayChildByName("btn_successStreng"));
            this.btn_StartSplit = new BaseButton(getDisplayChildByName("btn_start_split"));
            this.btn_rate = new BaseButton(getDisplayChildByName("btn_rate"));
            this.btn_backRate = new BaseButton(getDisplayChildByName("btn_backRate"));
            this.txt_SuitSplitCost = getDisplayChildByName("txt_suit_split_cost");
            this.luckPanel = getDisplayChildByName("luckPanel");
            this.suitPanel = new SuitPanel(getDisplayChildByName("suitPanel"));
            this.suitSplitView = getDisplayChildByName("mc_suit_view");
            this.txt_SplitEquip1 = this.suitSplitView.getChildByName("txt_split_equip1") as TextField;
            this.txt_SplitEquip1.mouseEnabled = false;
            this.txt_SplitEquip2 = this.suitSplitView.getChildByName("txt_split_equip2") as TextField;
            this.txt_SplitEquip2.mouseEnabled = false;
            this.txt_SplitStone1 = this.suitSplitView.getChildByName("txt_split_stone1") as TextField;
            this.txt_SplitStone1.mouseEnabled = false;
            this.txt_SplitStone2 = this.suitSplitView.getChildByName("txt_split_stone2") as TextField;
            this.txt_SplitStone2.mouseEnabled = false;
            this.txt_needMoneyValue = getDisplayChildByName("txt_needMoneyValue");
            this.baoshi1 = getDisplayChildByName("baoshi1");
            this.baoshi2 = getDisplayChildByName("baoshi2");
            this.baoshi3 = getDisplayChildByName("baoshi3");
            this._baoshiEquip1 = new EquipImage();
            this.baoshi1.addChild(this._baoshiEquip1);
            this._baoshiEquip2 = new EquipImage();
            this.baoshi2.addChild(this._baoshiEquip2);
            this._baoshiEquip3 = new EquipImage();
            this.baoshi3.addChild(this._baoshiEquip3);
            this.txt_name1 = getDisplayChildByName("txt_name1");
            this.txt_name2 = getDisplayChildByName("txt_name2");
            this.txt_name3 = getDisplayChildByName("txt_name3");
            this.txt_name3.visible = false;
            this.tipsImg = getDisplayChildByName("tipsImg");
            this.check_btn = new BaseButton(getDisplayChildByName("check_btn"), true);
            this.check_btn.selected = false;
            this.check_btn.setText(LanguageCfgObj.getInstance().getByIndex("10621"));
            this._curImage = new EquipImage();
            this.mc_CurEquip.addChild(this._curImage);
            this._preImage = new EquipImage();
            this.mc_PreEquip.addChild(this._preImage);
            this._hasInitUI = true;
            this.clear();
            this.update(this._type);
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_streng.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_successStreng.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_StartSplit.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_rate.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_backRate.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.check_btn.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this._curImage.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            FrameworkGlobal.stage.addEventListener(SysCueEvent.LINK, this.openVIp);
            return;
        }// end function

        private function openVIp(event:SysCueEvent = null) : void
        {
            if (event.data == "openVip")
            {
                VIPControl.getInstance().openOrCloseVip();
            }
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (!this._equipInfo)
            {
                return;
            }
            switch(event.target)
            {
                case this.btn_rate:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.vipid;
                    _loc_3 = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
                    _loc_4 = ItemCfgObj.getInstance().getCfgBy(this._equipInfo.itemModelId);
                    if (this._equipInfo.intensify >= _loc_4.q_max_strengthen)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10622"));
                        return;
                    }
                    if (!_loc_3)
                    {
                        SimpleTip.show(LanguageCfgObj.getInstance().getByIndex("10623"), 3000);
                        return;
                    }
                    _loc_5 = _loc_3.q_vip_level;
                    if (_loc_2 >= _loc_5)
                    {
                        this.vipState = 2;
                        this.img_successRate.setNumber("100%", 44);
                        ButtonFlickerControl.getInstance().addButtonFlicker(this.btn_successStreng);
                    }
                    else
                    {
                        _loc_7 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12001"), [this._equipInfo.intensify, _loc_5]) + LanguageCfgObj.getInstance().getByIndex("10624");
                        Global.popManager.cue(_loc_7, LanguageCfgObj.getInstance().getByIndex("10625"), null, null, null, 1);
                    }
                    var _loc_8:* = int(_loc_3.q_diamond) > 0 && this.vipState == 2;
                    this.txt_needMoneyValue.visible = int(_loc_3.q_diamond) > 0 && this.vipState == 2;
                    this.mc_diamond.visible = _loc_8;
                    this.txt_needMoney.visible = _loc_8;
                    break;
                }
                case this.btn_backRate:
                {
                    this.vipState = 1;
                    _loc_6 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.intensify + 1));
                    if (_loc_6)
                    {
                        this.img_successRate.setNumber(int(_loc_6.q_streng_show_pby / 100) + "%", 44);
                    }
                    else
                    {
                        this.img_successRate.setNumber("0%", 44);
                    }
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn_successStreng);
                    var _loc_8:* = false;
                    this.txt_needMoneyValue.visible = false;
                    this.mc_diamond.visible = _loc_8;
                    this.txt_needMoney.visible = _loc_8;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateState();
            return;
        }// end function

        private function updateState() : void
        {
            if (this.vipState == 1)
            {
                this.btn_rate.visible = true;
                this.btn_backRate.visible = false;
                this.btn_successStreng.visible = false;
                this.btn_streng.visible = true;
            }
            else if (this.vipState == 2)
            {
                this.btn_rate.visible = false;
                this.btn_backRate.visible = true;
                this.btn_successStreng.visible = true;
                this.btn_streng.visible = false;
            }
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            if (this._equipInfo == null)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10626"));
                return;
            }
            switch(event.target)
            {
                case this.btn_streng:
                {
                    if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE)
                    {
                        this.checkCanStreng(1);
                        ClickStream.add(ClickStreamId.CLICK_QiangHua_QiangHua);
                    }
                    else if (this._type == EquipOperationTypeCfg.ADDITION_TYPE)
                    {
                        this.checkCanStreng(this._type);
                        ClickStream.add(ClickStreamId.CLICK_ZuiJia_ZuiJia);
                    }
                    else if (this._type == EquipOperationTypeCfg.LUCKY_TYPE)
                    {
                        if (this._equipInfo.knowing_attackpercent)
                        {
                            Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10627"));
                            return;
                        }
                        this.checkCanStreng(this._type);
                    }
                    else if (this._type == EquipOperationTypeCfg.TRANS_SUIT_TYPE)
                    {
                        this.checkCanStreng(this._type);
                    }
                    else if (this._type == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
                    {
                        this.checkCanStreng(this._type);
                    }
                    break;
                }
                case this.btn_StartSplit:
                {
                    if (this._type == EquipOperationTypeCfg.TYPE_SUIT_SPLIT)
                    {
                        this.clickSuitSplit(this._type);
                    }
                    break;
                }
                case this.btn_successStreng:
                {
                    if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE)
                    {
                        _loc_2 = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
                        if (this.checkCanStreng(EquipOperationTypeCfg.VIP_OP_TYPE))
                        {
                            this._op = VIP_STRENGTH_OP;
                            this.playEffect();
                        }
                    }
                    else if (this._type == EquipOperationTypeCfg.ADDITION_TYPE)
                    {
                        if (this.checkCanStreng(EquipOperationTypeCfg.VIP_OP_TYPE))
                        {
                            this._op = VIP_PROCESS_OP;
                            this.playEffectProcess();
                        }
                    }
                    break;
                }
                case this.check_btn:
                {
                    this.checkBindState();
                    if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE)
                    {
                        this.showStreng();
                    }
                    else if (this._type == EquipOperationTypeCfg.ADDITION_TYPE)
                    {
                        this.showProcess();
                    }
                    else if (this._type == EquipOperationTypeCfg.LUCKY_TYPE)
                    {
                        this.showLuckAttr();
                    }
                    else if (this._type == EquipOperationTypeCfg.TRANS_SUIT_TYPE)
                    {
                        this.showSuit(this._type);
                    }
                    else if (this._type == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
                    {
                        this.showSuit(this._type);
                    }
                    break;
                }
                case this._curImage:
                {
                    this.clear();
                    this.refreshEquipList();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickSuitSplit(param1:int) : void
        {
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            if (!this._equipInfo && !this._equipInfo.suitId)
            {
                return;
            }
            var _loc_2:* = SuitCfgObj.instance.getSuitById(this._equipInfo.suitId);
            var _loc_3:* = _loc_2.q_split_coin;
            if (_loc_3 > UserObj.getInstance().playerInfo.money)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11136"));
                FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                return;
            }
            if (!this.suitSplitHit)
            {
                this.suitSplitHit = new EquipSuitSplitHit();
                Global.popManager.addPop(this.suitSplitHit, true, true, true, true, false, true);
                this.suitSplitHit.callBack = this.suitSplitBack;
            }
            if (!this.suitSplitHit.parent)
            {
                this.suitSplitHit.open();
            }
            return;
        }// end function

        private function suitSplitBack() : void
        {
            if (this._equipInfo && this._equipInfo.suitId)
            {
                EquipForgeControl.getInstance().equipSuitSplit(this._equipInfo.itemId);
            }
            return;
        }// end function

        private function checkCanStreng(param1:int = 1) : Boolean
        {
            var equipStrengCfg:Object;
            var haveNumber1:int;
            var haveNumber2:int;
            var haveNumber3:int;
            var itemCfg:Object;
            var suitId:int;
            var vip:int;
            var cfgObj:Object;
            var needVip:int;
            var str:String;
            var canShow:Boolean;
            var tips:String;
            var type:* = param1;
            switch(this._type)
            {
                case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                {
                    itemCfg = ItemCfgObj.getInstance().getCfgBy(this._equipInfo.itemModelId);
                    if (this._equipInfo.intensify >= itemCfg.q_max_strengthen)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10622"));
                        return false;
                    }
                    equipStrengCfg = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.intensify + 1));
                    break;
                }
                case EquipOperationTypeCfg.ADDITION_TYPE:
                {
                    equipStrengCfg = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.addAttributLevel + 1));
                    if (!equipStrengCfg)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10629"));
                        return false;
                    }
                    break;
                }
                case EquipOperationTypeCfg.LUCKY_TYPE:
                {
                    equipStrengCfg = LuckStoneCfg.LUCK_STONE_CFG;
                    break;
                }
                case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                {
                    if (this._equipInfo.suitId)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10630"));
                        return false;
                    }
                    equipStrengCfg = this.getSuitCfg(this._equipInfo.getSuit_convert_consumeBySuitId(this._equipInfo.getNextSuitId(this._equipInfo.suitId)));
                    break;
                }
                case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                {
                    suitId = this._equipInfo.getNextSuitId(this._equipInfo.suitId);
                    if (suitId == this._equipInfo.suitId)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12436"));
                        return false;
                    }
                    equipStrengCfg = this.getSuitCfg(this._equipInfo.getSuit_convert_consumeBySuitId(this._equipInfo.getNextSuitId(this._equipInfo.suitId)));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (type == EquipOperationTypeCfg.VIP_OP_TYPE)
            {
                vip = UserObj.getInstance().playerInfo.vipid;
                cfgObj = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
                needVip = cfgObj.q_vip_level;
                str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12001"), [this._equipInfo.intensify, needVip]) + LanguageCfgObj.getInstance().getByIndex("10624");
                if (vip < needVip)
                {
                    Global.popManager.cue(str, LanguageCfgObj.getInstance().getByIndex("10625"), null, null, null, 1);
                    return false;
                }
                if (UserObj.getInstance().playerInfo.gold < int(cfgObj.q_diamond))
                {
                    MapControl.getInstance().showRechargeD();
                    return false;
                }
            }
            if (!this.check_btn.selected)
            {
                haveNumber1 = BackpackObj.getInstance().getItemCount(equipStrengCfg.q_material_id_01);
                haveNumber2 = BackpackObj.getInstance().getItemCount(equipStrengCfg.q_material_id_02);
                haveNumber3 = BackpackObj.getInstance().getItemCount(equipStrengCfg.q_material_id_03);
                if (haveNumber1 < equipStrengCfg.q_material_num_01 || haveNumber2 < equipStrengCfg.q_material_num_02 || haveNumber3 < equipStrengCfg.q_material_num_03)
                {
                    this.checkEnoughForFun(equipStrengCfg, haveNumber1, haveNumber2, haveNumber3);
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10633"));
                    return false;
                }
            }
            else
            {
                haveNumber1 = BackpackObj.getInstance().getItemNotBindCount(equipStrengCfg.q_material_id_01);
                haveNumber2 = BackpackObj.getInstance().getItemNotBindCount(equipStrengCfg.q_material_id_02);
                haveNumber3 = BackpackObj.getInstance().getItemNotBindCount(equipStrengCfg.q_material_id_03);
                if (haveNumber1 < equipStrengCfg.q_material_num_01 || haveNumber2 < equipStrengCfg.q_material_num_02 || haveNumber3 < equipStrengCfg.q_material_num_03)
                {
                    this.checkEnoughForFun(equipStrengCfg, haveNumber1, haveNumber2, haveNumber3);
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10633"));
                    return false;
                }
            }
            if (UserObj.getInstance().playerInfo.money < equipStrengCfg.q_streng_money)
            {
                FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10635"));
                return false;
            }
            if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE && type == EquipOperationTypeCfg.STRENGTHEN_TYPE)
            {
                cfgObj = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
                if (!cfgObj)
                {
                    SimpleTip.show(LanguageCfgObj.getInstance().getByIndex("10623"), 3000);
                    return false;
                }
                vip = UserObj.getInstance().playerInfo.vipid;
                canShow = equipStrengCfg.q_streng_show_pby / 100 < 100 && vip > 0 && int(cfgObj.q_vip_level) != -1;
                if (this._equipInfo.intensify == 6 && !canShow && !this.hasOpenTips1 && !this.hasOpenTipsDay1)
                {
                    tips = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12002"), [this._equipInfo.intensify, (this._equipInfo.intensify + 1)]);
                    Global.popManager.cue(tips, LanguageCfgObj.getInstance().getByIndex("10637"), null, function () : void
            {
                bindTips(equipStrengCfg, type);
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10638"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay1 = param1;
                return;
            }// end function
            );
                    this.hasOpenTips1 = true;
                    return false;
                }
                if (this._equipInfo.intensify == 6 && canShow && this.vipState != 2 && !this.hasOpenTips2 && !this.hasOpenTipsDay2)
                {
                    tips = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12003"), [this._equipInfo.intensify, (this._equipInfo.intensify + 1)]);
                    Global.popManager.cue(tips, LanguageCfgObj.getInstance().getByIndex("10637"), null, function () : void
            {
                btn_rate.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10640"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay2 = param1;
                return;
            }// end function
            );
                    this.hasOpenTips2 = true;
                    return false;
                }
                if (this._equipInfo.intensify >= 7 && !canShow && !this.hasOpenTips3 && !this.hasOpenTipsDay3)
                {
                    tips = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12004"), [this._equipInfo.intensify, (this._equipInfo.intensify + 1)]);
                    Global.popManager.cue(tips, LanguageCfgObj.getInstance().getByIndex("10637"), null, function () : void
            {
                bindTips(equipStrengCfg, type);
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10638"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay3 = param1;
                return;
            }// end function
            );
                    this.hasOpenTips3 = true;
                    return false;
                }
                if (this._equipInfo.intensify >= 7 && canShow && this.vipState != 2 && !this.hasOpenTips4 && !this.hasOpenTipsDay4)
                {
                    tips = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12005"), [this._equipInfo.intensify, (this._equipInfo.intensify + 1)]);
                    Global.popManager.cue(tips, LanguageCfgObj.getInstance().getByIndex("10637"), null, function () : void
            {
                btn_rate.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10640"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay4 = param1;
                return;
            }// end function
            );
                    this.hasOpenTips4 = true;
                    return false;
                }
            }
            return this.bindTips(equipStrengCfg, type);
        }// end function

        private function bindTips(param1:Object, param2:int) : Boolean
        {
            var band1:int;
            var band2:int;
            var band3:int;
            var str1:String;
            var str2:String;
            var cfgObj:Object;
            var equipStrengCfg:* = param1;
            var type:* = param2;
            if (!this.check_btn.selected)
            {
                if (!this._equipInfo.isbind)
                {
                    band1 = BackpackObj.getInstance().getItemBindCount(equipStrengCfg.q_material_id_01);
                    band2 = BackpackObj.getInstance().getItemBindCount(equipStrengCfg.q_material_id_02);
                    band3 = BackpackObj.getInstance().getItemBindCount(equipStrengCfg.q_material_id_03);
                    if (band1 || band2 || band3)
                    {
                        str1;
                        str2;
                        switch(this._type)
                        {
                            case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                            {
                                str1 = LanguageCfgObj.getInstance().getByIndex("10645");
                                str2 = LanguageCfgObj.getInstance().getByIndex("10646");
                                break;
                            }
                            case EquipOperationTypeCfg.ADDITION_TYPE:
                            {
                                str1 = LanguageCfgObj.getInstance().getByIndex("10647");
                                str2 = LanguageCfgObj.getInstance().getByIndex("10648");
                                break;
                            }
                            case EquipOperationTypeCfg.LUCKY_TYPE:
                            {
                                str1 = LanguageCfgObj.getInstance().getByIndex("10649");
                                str2 = LanguageCfgObj.getInstance().getByIndex("10650");
                                break;
                            }
                            case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                            {
                                str1 = LanguageCfgObj.getInstance().getByIndex("10651");
                                str2 = LanguageCfgObj.getInstance().getByIndex("10652");
                                break;
                            }
                            case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                            {
                                str1 = LanguageCfgObj.getInstance().getByIndex("12432");
                                str2 = LanguageCfgObj.getInstance().getByIndex("12433");
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        Global.popManager.cue(str1, "", null, function () : void
            {
                var cfgObj:Object;
                if (_type == 1 && type == 2 && !hasOpenTipsDiamond && !hasOpenTipsDiamondDay)
                {
                    cfgObj = VipStrengCfgObj.getInstance().getVipStrengInfo(_equipInfo.intensify, _equipInfo.q_equip_steplv);
                    Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12006"), [cfgObj.q_diamond]), LanguageCfgObj.getInstance().getByIndex("12007"), null, function () : void
                {
                    _op = VIP_STRENGTH_OP;
                    playEffect();
                    return;
                }// end function
                , null, 2, LanguageCfgObj.getInstance().getByIndex("10653"), false, true, function (param1:Boolean) : void
                {
                    hasOpenTipsDiamondDay = param1;
                    return;
                }// end function
                );
                    hasOpenTipsDiamond = true;
                    return;
                }
                switch(_type)
                {
                    case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                    {
                        if (type == EquipOperationTypeCfg.VIP_OP_TYPE)
                        {
                            _op = VIP_STRENGTH_OP;
                        }
                        else
                        {
                            _op = STRENGTH2_OP;
                        }
                        playEffect();
                        break;
                    }
                    case EquipOperationTypeCfg.ADDITION_TYPE:
                    {
                        _op = PROCESS2_OP;
                        playEffectProcess();
                        break;
                    }
                    case EquipOperationTypeCfg.LUCKY_TYPE:
                    {
                        _op = LUCK_ADD_OP;
                        playEffect();
                        break;
                    }
                    case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                    {
                        _op = TRANS_SUIT_OP;
                        playEffect();
                        break;
                    }
                    case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                    {
                        _op = STRENGTH_SUIT_OP;
                        playEffect();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            , null, 2, str2);
                        return false;
                    }
                }
            }
            if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE && type == EquipOperationTypeCfg.VIP_OP_TYPE && !this.hasOpenTipsDiamond && !this.hasOpenTipsDiamondDay)
            {
                cfgObj = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12356"), [cfgObj.q_diamond]), LanguageCfgObj.getInstance().getByIndex("11869"), null, function () : void
            {
                _op = VIP_STRENGTH_OP;
                playEffect();
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10653"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDiamondDay = param1;
                return;
            }// end function
            );
                this.hasOpenTipsDiamond = true;
                return false;
            }
            switch(this._type)
            {
                case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                {
                    this._op = STRENGTH1_OP;
                    this.playEffect();
                    break;
                }
                case EquipOperationTypeCfg.ADDITION_TYPE:
                {
                    this._op = PROCESS1_OP;
                    this.playEffectProcess();
                    break;
                }
                case EquipOperationTypeCfg.LUCKY_TYPE:
                {
                    this._op = LUCK_ADD_OP;
                    this.playEffect();
                    break;
                }
                case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                {
                    this._op = TRANS_SUIT_OP;
                    this.playEffect();
                }
                case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                {
                    this._op = STRENGTH_SUIT_OP;
                    this.playEffect();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return true;
        }// end function

        private function checkEnoughForFun(param1:Object, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = [[ItemConst.BLESS_STONE, FunGuideConst.BLESS], [ItemConst.SOUL_STONE, FunGuideConst.SOUL], [ItemConst.LIFE_STONE, FunGuideConst.LIFE]];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (param1.q_material_id_01 == _loc_5[_loc_6][0])
                {
                    if (param1.q_material_num_01 > param2)
                    {
                        FunGuideControl.getInstance().showRemind(_loc_5[_loc_6][1]);
                    }
                }
                else if (param1.q_material_id_02 == _loc_5[_loc_6][0])
                {
                    if (param1.q_material_num_02 > param3)
                    {
                        FunGuideControl.getInstance().showRemind(_loc_5[_loc_6][1]);
                    }
                }
                else if (param1.q_material_id_03 == _loc_5[_loc_6][0])
                {
                    if (param1.q_material_num_03 > param4)
                    {
                        FunGuideControl.getInstance().showRemind(_loc_5[_loc_6][1]);
                    }
                }
                _loc_6++;
            }
            return;
        }// end function

        private function send(event:Event = null) : void
        {
            if (!this._equipInfo)
            {
                return;
            }
            switch(this._op)
            {
                case STRENGTH1_OP:
                {
                    EquipForgeControl.getInstance().reqEquipStreng(this._equipInfo.itemId, this.check_btn.selected ? (3) : (4));
                    break;
                }
                case PROCESS1_OP:
                {
                    EquipForgeControl.getInstance().reqEquipProcess(this._equipInfo.itemId, this.check_btn.selected ? (3) : (4));
                    break;
                }
                case STRENGTH2_OP:
                {
                    EquipForgeControl.getInstance().reqEquipStreng(this._equipInfo.itemId, this.check_btn.selected ? (3) : (4));
                    break;
                }
                case PROCESS2_OP:
                {
                    EquipForgeControl.getInstance().reqEquipProcess(this._equipInfo.itemId, this.check_btn.selected ? (3) : (4));
                    break;
                }
                case VIP_STRENGTH_OP:
                {
                    EquipForgeControl.getInstance().reqEquipStreng(this._equipInfo.itemId, this.check_btn.selected ? (3) : (4), -1);
                    break;
                }
                case VIP_PROCESS_OP:
                {
                    EquipForgeControl.getInstance().reqEquipProcess(this._equipInfo.itemId, 2);
                    break;
                }
                case LUCK_ADD_OP:
                {
                    EquipForgeControl.getInstance().reqAttachStoneHandle(this._equipInfo.itemId, this.check_btn.selected ? (0) : (1));
                    break;
                }
                case TRANS_SUIT_OP:
                {
                    EquipForgeControl.getInstance().reqConvertSuit(this._equipInfo.itemId, this.check_btn.selected ? (1) : (0));
                    break;
                }
                case STRENGTH_SUIT_OP:
                {
                    EquipForgeControl.getInstance().reqConvertSuit(this._equipInfo.itemId, this.check_btn.selected ? (1) : (0));
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this._type)
            {
                case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                {
                    this.playFireEffect();
                    break;
                }
                case EquipOperationTypeCfg.ADDITION_TYPE:
                {
                    this.playFireEffectProcess();
                    break;
                }
                case EquipOperationTypeCfg.LUCKY_TYPE:
                {
                    this.playFireEffect();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._isPlayingEffect = false;
            this.updateEnabled(this._isPlayingEffect);
            return;
        }// end function

        private function checkBindState() : void
        {
            var _loc_2:* = null;
            if (!this._equipInfo)
            {
                return;
            }
            var _loc_1:* = false;
            switch(this._type)
            {
                case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                {
                    _loc_2 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.intensify + 1));
                    break;
                }
                case EquipOperationTypeCfg.ADDITION_TYPE:
                {
                    _loc_2 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.addAttributLevel + 1));
                    break;
                }
                case EquipOperationTypeCfg.LUCKY_TYPE:
                {
                    _loc_2 = LuckStoneCfg.LUCK_STONE_CFG;
                    break;
                }
                case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                {
                    _loc_2 = this.getSuitCfg(this._equipInfo.getSuit_convert_consumeBySuitId(this._equipInfo.getNextSuitId(this._equipInfo.suitId)));
                    break;
                }
                case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                {
                    _loc_2 = this.getSuitCfg(this._equipInfo.getSuit_convert_consumeBySuitId(this._equipInfo.getNextSuitId(this._equipInfo.suitId)));
                    break;
                }
                case EquipOperationTypeCfg.TYPE_SUIT_SPLIT:
                {
                    return;
                }
                default:
                {
                    break;
                }
            }
            if (!_loc_2)
            {
                SimpleTip.show(LanguageCfgObj.getInstance().getByIndex("10655"), 3000);
                this._equipInfo = null;
                return;
            }
            var _loc_3:* = BackpackObj.getInstance().getItemBindCount(_loc_2.q_material_id_01);
            var _loc_4:* = BackpackObj.getInstance().getItemBindCount(_loc_2.q_material_id_02);
            var _loc_5:* = BackpackObj.getInstance().getItemBindCount(_loc_2.q_material_id_03);
            if (_loc_3 || _loc_4 || _loc_5)
            {
                _loc_1 = true;
            }
            else
            {
                _loc_1 = false;
            }
            if (_loc_1)
            {
                this._preImage.bind = !this.check_btn.selected;
            }
            else
            {
                this._preImage.bind = false;
            }
            return;
        }// end function

        public function __selectItem(event:MouseEvent = null) : void
        {
            var _loc_2:* = (event.target as EquipSelectItem).info;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(_loc_2.itemModelId);
            if (this._type == 1 && _loc_2.intensify >= _loc_3.q_max_strengthen)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10622"));
                return;
            }
            var _loc_4:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(_loc_2.itemModelId + "_" + (_loc_2.addAttributLevel + 1));
            if (this._type == 2 && !_loc_4)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10629"));
                return;
            }
            if (this._type == 3 && _loc_2.knowing_attackpercent != 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10627"));
            }
            this.hasOpenTips1 = false;
            this.hasOpenTips2 = false;
            this.hasOpenTips3 = false;
            this.hasOpenTips4 = false;
            this.hasOpenTipsDiamond = false;
            this.vipState = 1;
            this.refreshEquipShow(_loc_2);
            this.checkBindState();
            if (this._lastItem)
            {
                this._lastItem.select = false;
            }
            this._lastItem = event.target as EquipSelectItem;
            event.target.select = true;
            this._lastStrengEquipInfo = _loc_2;
            return;
        }// end function

        public function clear() : void
        {
            this.txt_needMoneyValue.text = "";
            this.img_successRate.reset();
            this._equipInfo = null;
            this._list.reset();
            if (this._curImage)
            {
                this._curImage.setInfo(null);
            }
            if (this._preImage)
            {
                this._preImage.setInfo(null);
            }
            var _loc_1:* = 0;
            while (_loc_1 < 3)
            {
                
                this["txt_name" + (_loc_1 + 1)].text = "";
                _loc_1++;
            }
            this.attributeDetailPanel.clear();
            this.scorePanel.visible = false;
            this.baoshi1.visible = false;
            this.baoshi2.visible = false;
            this.baoshi3.visible = false;
            this.levelReviewPanel.visible = false;
            var _loc_2:* = 0;
            while (_loc_2 < this._fireVmcArray.length)
            {
                
                this._fireVmcArray[_loc_2].stop();
                this._fireVmcArray[_loc_2].visible = false;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this._fireVmcArray2.length)
            {
                
                this._fireVmcArray2[_loc_2].stop();
                this._fireVmcArray2[_loc_2].visible = false;
                _loc_2++;
            }
            this.btn_rate.visible = false;
            this.btn_backRate.visible = false;
            this.btn_successStreng.visible = false;
            this.vipState = 1;
            this.btn_streng.enabled = true;
            this.btn_successStreng.enabled = true;
            var _loc_3:* = false;
            this.txt_needMoneyValue.visible = false;
            this.mc_diamond.visible = _loc_3;
            this.txt_needMoney.visible = _loc_3;
            MyDispatcher.myEvent.dispatchEvent(new VideoEvent(VideoEvent.VIDEO_CLOSE));
            return;
        }// end function

        public function update(param1:int = 1) : void
        {
            if (!this._hasInitUI)
            {
                this._type = param1;
                return;
            }
            if (this._type != param1)
            {
                this.clear();
                this._type = param1;
            }
            this.refreshUI(param1);
            this.refreshEquipList();
            return;
        }// end function

        private function refreshUI(param1:int = 1) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.vipid;
            switch(param1)
            {
                case EquipOperationTypeCfg.STRENGTHEN_TYPE:
                {
                    this.text_preview.htmlText = LanguageCfgObj.getInstance().getByIndex("10659");
                    this.btn_streng.setText(LanguageCfgObj.getInstance().getByIndex("10660"));
                    this.btn_successStreng.setText(LanguageCfgObj.getInstance().getByIndex("10661"));
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("10662");
                    this.scoreTitle.text = LanguageCfgObj.getInstance().getByIndex("10663");
                    this.mc_bgSuccess.visible = true;
                    this.btn_rate.visible = true;
                    this.mc_bgSuccess.gotoAndStop(1);
                    this.img_successRate.visible = true;
                    this.luckPanel.visible = false;
                    this.suitPanel.visible = false;
                    this.resetSuitSplitUI();
                    break;
                }
                case EquipOperationTypeCfg.ADDITION_TYPE:
                {
                    this.text_preview.htmlText = LanguageCfgObj.getInstance().getByIndex("10664");
                    this.btn_streng.setText(LanguageCfgObj.getInstance().getByIndex("10665"));
                    this.btn_successStreng.setText(LanguageCfgObj.getInstance().getByIndex("10666"));
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("10667");
                    this.scoreTitle.text = LanguageCfgObj.getInstance().getByIndex("10663");
                    this.levelReviewPanel.visible = false;
                    this.mc_bgSuccess.visible = true;
                    this.mc_bgSuccess.gotoAndStop(2);
                    this.img_successRate.visible = true;
                    this.luckPanel.visible = false;
                    this.suitPanel.visible = false;
                    this.resetSuitSplitUI();
                    break;
                }
                case EquipOperationTypeCfg.LUCKY_TYPE:
                {
                    this.text_preview.htmlText = LanguageCfgObj.getInstance().getByIndex("10669");
                    this.btn_streng.setText(LanguageCfgObj.getInstance().getByIndex("10670"));
                    this.btn_successStreng.setText(LanguageCfgObj.getInstance().getByIndex("10666"));
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("10672");
                    this.scoreTitle.text = LanguageCfgObj.getInstance().getByIndex("10673");
                    this.levelReviewPanel.visible = false;
                    this.mc_bgSuccess.visible = false;
                    this.btn_rate.visible = false;
                    this.img_successRate.visible = false;
                    this.luckPanel.visible = true;
                    this.suitPanel.visible = false;
                    this.resetSuitSplitUI();
                    break;
                }
                case EquipOperationTypeCfg.TRANS_SUIT_TYPE:
                {
                    this.text_preview.htmlText = LanguageCfgObj.getInstance().getByIndex("10674");
                    this.btn_streng.setText(LanguageCfgObj.getInstance().getByIndex("10675"));
                    this.btn_successStreng.setText(LanguageCfgObj.getInstance().getByIndex("10666"));
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("10677");
                    this.scoreTitle.text = LanguageCfgObj.getInstance().getByIndex("10663");
                    this.levelReviewPanel.visible = false;
                    this.mc_bgSuccess.visible = false;
                    this.mc_bgSuccess.gotoAndStop(2);
                    this.img_successRate.visible = false;
                    this.luckPanel.visible = false;
                    this.suitPanel.visible = true;
                    this.suitPanel.clear(this._type);
                    this.resetSuitSplitUI();
                    break;
                }
                case EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE:
                {
                    this.text_preview.htmlText = LanguageCfgObj.getInstance().getByIndex("10674");
                    this.btn_streng.setText(LanguageCfgObj.getInstance().getByIndex("12412"));
                    this.btn_successStreng.setText(LanguageCfgObj.getInstance().getByIndex("10666"));
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("12411");
                    this.scoreTitle.text = LanguageCfgObj.getInstance().getByIndex("10663");
                    this.levelReviewPanel.visible = false;
                    this.mc_bgSuccess.visible = false;
                    this.mc_bgSuccess.gotoAndStop(2);
                    this.img_successRate.visible = false;
                    this.luckPanel.visible = false;
                    this.suitPanel.visible = true;
                    this.suitPanel.clear(this._type);
                    this.resetSuitSplitUI();
                    break;
                }
                case EquipOperationTypeCfg.TYPE_SUIT_SPLIT:
                {
                    this.text_preview.htmlText = "";
                    this.btn_successStreng.setText("");
                    this.txt_label.htmlText = LanguageCfgObj.getInstance().getByIndex("12442");
                    this.scoreTitle.text = "";
                    this.levelReviewPanel.visible = false;
                    this.mc_bgSuccess.visible = false;
                    this.mc_bgSuccess.gotoAndStop(2);
                    this.img_successRate.visible = false;
                    this.luckPanel.visible = false;
                    this.suitPanel.visible = false;
                    this.suitPanel.clear(this._type);
                    this.setSuitSplitUI();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function refreshEquipList(param1:Boolean = true) : void
        {
            var _loc_5:* = null;
            this._list.reset();
            var _loc_2:* = EquipForgeData.getInstance().filterEquip(this._type);
            var _loc_3:* = false;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                this._listItem = new EquipSelectItem();
                this._listItem.obj = _loc_2[_loc_4];
                this._listItem.addEvtListener(MouseEvent.CLICK, this.__selectItem);
                this._list.add(this._listItem);
                if (this._type == 1 && _loc_2[_loc_4] == this._lastStrengEquipInfo || this._type == 2 && _loc_2[_loc_4] == this._lastProcessEquipInfo)
                {
                    this._listItem.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    _loc_3 = true;
                }
                _loc_4++;
            }
            if (param1 && !_loc_3 && _loc_2.length)
            {
                _loc_5 = this._list.getContent(0);
                _loc_5.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        public function refreshEquipShow(param1:Object, param2:int = -2) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1 is EquipInfo)
            {
                _loc_3 = true;
                _loc_4 = BackpackObj.getInstance().getItemById(param1.itemId) as EquipmentInfo;
                if (!_loc_4)
                {
                    _loc_3 = false;
                    _loc_4 = EquipsObj.getInstance().getEquipById(param1.itemId) as EquipmentInfo;
                }
                _loc_4.con(param1 as EquipInfo, (_loc_4.pos - 1));
                if (_loc_3)
                {
                    BackPackControl.getInstance().updateItem(_loc_4);
                }
                _loc_5 = EquipForgeData.getInstance().fromStrengOrProcess;
                if (this._list.selectItem && this._lastStrengEquipInfo && this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                    this._list.selectItem.obj = _loc_4;
                    (this._list.selectItem as EquipSelectItem).refresh();
                    this._equipInfo = _loc_4;
                }
            }
            else if (param1 is EquipmentInfo)
            {
                this._equipInfo = param1 as EquipmentInfo;
            }
            if (this._type == EquipOperationTypeCfg.STRENGTHEN_TYPE)
            {
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showStreng();
                }
                if (param2 == 1)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/strengSuccess.png");
                    SoundControl.getInstance().playSound(SoundFlag.SUCCESS_STRENTH);
                }
                else if (param2 == 0)
                {
                    SoundControl.getInstance().playSound(SoundFlag.FAILE_STRENTH);
                    this.playerSuccessFailEffect("res/effect/failtips/strengFail.png");
                }
            }
            else if (this._type == EquipOperationTypeCfg.ADDITION_TYPE)
            {
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showProcess();
                }
                if (param2 == 1)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/processSuccess.png");
                }
                else if (param2 == 0)
                {
                    this.playerSuccessFailEffect("res/effect/failtips/processFail.png");
                }
            }
            else if (this._type == EquipOperationTypeCfg.LUCKY_TYPE)
            {
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showLuckAttr();
                }
                if (param2 > 0)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/luckSuccess.png");
                    this.refreshEquipList(false);
                }
                else if (param2 == 0)
                {
                    this.playerSuccessFailEffect("res/effect/failtips/processFail.png");
                }
            }
            else if (this._type == EquipOperationTypeCfg.TRANS_SUIT_TYPE)
            {
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showSuit(this._type);
                }
                if (param2 > 0)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/suitSuccess.png");
                }
            }
            else if (this._type == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
            {
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showSuit(this._type);
                }
                if (param2 > 0)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/strengSuccess.png");
                }
            }
            else if (this._type == EquipOperationTypeCfg.TYPE_SUIT_SPLIT)
            {
                this.suitSplitPlayEffect(this._equipInfo, param1);
                if (param1 is EquipInfo && this._lastStrengEquipInfo && !this._lastStrengEquipInfo.itemId.equal(param1.itemId))
                {
                }
                else
                {
                    this.showSuitSplit(this._type);
                }
                if (param2 > 0)
                {
                    this.playerSuccessFailEffect("res/effect/successtips/splitSuit.png", -121, 0);
                }
            }
            return;
        }// end function

        private function showStreng() : void
        {
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = null;
            var _loc_26:* = NaN;
            if (!this._equipInfo)
            {
                return;
            }
            this._curImage.setInfo(this._equipInfo, false, "res/effect/strengEffect.png", 56, 56, 3);
            var _loc_1:* = this._equipInfo.cloneEquip() as EquipmentInfo;
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(_loc_1.itemModelId);
            if (_loc_1.intensify < _loc_2.q_max_strengthen)
            {
                (_loc_1.intensify + 1);
            }
            _loc_1.setAttributeEquipStrengCfg(_loc_1.intensify, _loc_1.addAttributLevel);
            this._preImage.setInfo(_loc_1, false, "res/effect/strengEffect.png", 56, 56, 3);
            this.scorePanel.visible = true;
            this.scorePanel.setNumber("" + this._equipInfo.fightNumber, 3, -5);
            this.scorePanel.setAddedNumber("" + (_loc_1.fightNumber - this._equipInfo.fightNumber), 5, -5);
            var _loc_3:* = PropUtil.getEquipNameAndColor(_loc_1);
            var _loc_4:* = _loc_3[0].split("  ");
            var _loc_5:* = 0;
            while (_loc_5 < (_loc_4.length - 1))
            {
                
                this["txt_name" + (_loc_5 + 1)].visible = true;
                this["txt_name" + (_loc_5 + 1)].htmlText = _loc_4[_loc_5];
                _loc_5++;
            }
            var _loc_6:* = _loc_5;
            while (_loc_6 <= (_loc_4.length - 1))
            {
                
                this["txt_name" + (_loc_6 + 1)].visible = false;
                _loc_6++;
            }
            var _loc_27:* = _loc_3[1];
            this.txt_name3.textColor = _loc_3[1];
            this.txt_name2.textColor = _loc_27;
            this.txt_name1.textColor = _loc_27;
            this.levelReviewPanel.visible = true;
            this.levelReviewPanel.showLevel(this._equipInfo.intensify, _loc_1.intensify);
            var _loc_7:* = [];
            var _loc_8:* = [];
            var _loc_9:* = 0;
            if (_loc_1.q_max_physicattack)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11953") + this._equipInfo.q_min_physicattack + "~" + this._equipInfo.q_max_physicattack;
                _loc_8[_loc_9] = _loc_1.q_max_physicattack - this._equipInfo.q_max_physicattack;
                _loc_9++;
            }
            if (_loc_1.q_max_magicattack)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12008") + this._equipInfo.q_min_magicattack + "~" + this._equipInfo.q_max_magicattack;
                _loc_8[_loc_9] = _loc_1.q_max_magicattack - this._equipInfo.q_max_magicattack;
                _loc_9++;
            }
            if (_loc_1.q_physicattack_Percent)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12009") + this._equipInfo.q_physicattack_Percent + "%";
                _loc_8[_loc_9] = _loc_1.q_physicattack_Percent - this._equipInfo.q_physicattack_Percent;
                _loc_9++;
            }
            if (_loc_1.q_magicattack_Percent)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12010") + this._equipInfo.q_magicattack_Percent + "%";
                _loc_8[_loc_9] = _loc_1.q_magicattack_Percent - this._equipInfo.q_magicattack_Percent;
                _loc_9++;
            }
            if (_loc_1.q_defence)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11793") + this._equipInfo.q_defence;
                _loc_8[_loc_9] = _loc_1.q_defence - this._equipInfo.q_defence;
                _loc_9++;
            }
            if (_loc_1.q_hit)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11952") + this._equipInfo.q_hit;
                _loc_8[_loc_9] = _loc_1.q_hit - this._equipInfo.q_hit;
                _loc_9++;
            }
            if (_loc_1.q_dodge)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11795") + this._equipInfo.q_dodge;
                _loc_8[_loc_9] = _loc_1.q_dodge - this._equipInfo.q_dodge;
                _loc_9++;
            }
            if (_loc_1.q_max_hp)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12011") + this._equipInfo.q_max_hp;
                _loc_8[_loc_9] = _loc_1.q_max_hp - this._equipInfo.q_max_hp;
                _loc_9++;
            }
            if (_loc_1.q_max_mp)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12012") + this._equipInfo.q_max_mp;
                _loc_8[_loc_9] = _loc_1.q_max_mp - this._equipInfo.q_max_mp;
                _loc_9++;
            }
            if (_loc_1.q_attackspeed)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11798") + this._equipInfo.q_attackspeed;
                _loc_8[_loc_9] = _loc_1.q_attackspeed - this._equipInfo.q_attackspeed;
                _loc_9++;
            }
            if (_loc_1.q_speed)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11799") + this._equipInfo.q_speed;
                _loc_8[_loc_9] = _loc_1.q_speed - this._equipInfo.q_speed;
                _loc_9++;
            }
            if (_loc_1.q_add_injure)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11806") + int(this._equipInfo.q_add_injure / 100) + "%";
                _loc_8[_loc_9] = (_loc_1.q_add_injure - this._equipInfo.q_add_injure) / 100 + "%";
                _loc_9++;
            }
            if (_loc_1.q_reduce_injure)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("11807") + int(this._equipInfo.q_reduce_injure / 100) + "%";
                _loc_8[_loc_9] = (_loc_1.q_reduce_injure - this._equipInfo.q_reduce_injure) / 100 + "%";
                _loc_9++;
            }
            if (_loc_1.q_element_attack1)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12013") + this._equipInfo.q_element_attack1;
                _loc_8[_loc_9] = _loc_1.q_element_attack1 - this._equipInfo.q_element_attack1;
                _loc_9++;
            }
            if (_loc_1.q_element_attack2)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12014") + this._equipInfo.q_element_attack2;
                _loc_8[_loc_9] = _loc_1.q_element_attack2 - this._equipInfo.q_element_attack2;
                _loc_9++;
            }
            if (_loc_1.q_element_attack3)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12015") + this._equipInfo.q_element_attack3;
                _loc_8[_loc_9] = _loc_1.q_element_attack3 - this._equipInfo.q_element_attack3;
                _loc_9++;
            }
            if (_loc_1.q_element_defence1)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12016") + this._equipInfo.q_element_defence1;
                _loc_8[_loc_9] = _loc_1.q_element_defence1 - this._equipInfo.q_element_defence1;
                _loc_9++;
            }
            if (_loc_1.q_element_defence2)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12017") + this._equipInfo.q_element_defence2;
                _loc_8[_loc_9] = _loc_1.q_element_defence2 - this._equipInfo.q_element_defence2;
                _loc_9++;
            }
            if (_loc_1.q_element_defence3)
            {
                _loc_7[_loc_9] = LanguageCfgObj.getInstance().getByIndex("12018") + this._equipInfo.q_element_defence3;
                _loc_8[_loc_9] = _loc_1.q_element_defence3 - this._equipInfo.q_element_defence3;
                _loc_9++;
            }
            this.attributeDetailPanel.visible = true;
            this.attributeDetailPanel.setAttribute(_loc_7, _loc_8, true);
            var _loc_10:* = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.intensify + 1));
            if (!EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.intensify + 1)))
            {
                return;
            }
            if (this.check_btn.selected)
            {
                _loc_21 = BackpackObj.getInstance().getItemNotBindCount(_loc_10.q_material_id_01);
                _loc_22 = BackpackObj.getInstance().getItemNotBindCount(_loc_10.q_material_id_02);
                _loc_23 = BackpackObj.getInstance().getItemNotBindCount(_loc_10.q_material_id_03);
            }
            else
            {
                _loc_21 = BackpackObj.getInstance().getItemCount(_loc_10.q_material_id_01);
                _loc_22 = BackpackObj.getInstance().getItemCount(_loc_10.q_material_id_02);
                _loc_23 = BackpackObj.getInstance().getItemCount(_loc_10.q_material_id_03);
            }
            this._baoshiEquip1.setInfo(PropUtil.createItemByCfg(_loc_10.q_material_id_01), false, "", 40, 40);
            this.baoshi1.visible = true;
            if (_loc_10.q_material_id_02)
            {
                this._baoshiEquip2.setInfo(PropUtil.createItemByCfg(_loc_10.q_material_id_02), false, "", 40, 40);
                this.baoshi2.visible = true;
            }
            else
            {
                this.baoshi2.visible = false;
            }
            if (_loc_10.q_material_id_03)
            {
                this._baoshiEquip3.setInfo(PropUtil.createItemByCfg(_loc_10.q_material_id_03), false, "", 40, 40);
                this.baoshi3.visible = true;
            }
            else
            {
                this.baoshi3.visible = false;
            }
            var _loc_11:* = _loc_21 < _loc_10.q_material_num_01 ? (16711680) : (16777215);
            var _loc_12:* = _loc_22 < _loc_10.q_material_num_02 ? (16711680) : (16777215);
            var _loc_13:* = _loc_23 < _loc_10.q_material_num_03 ? (16711680) : (16777215);
            this._baoshiEquip1.image.countTxt.textColor = _loc_11;
            this._baoshiEquip2.image.countTxt.textColor = _loc_12;
            this._baoshiEquip3.image.countTxt.textColor = _loc_13;
            this._baoshiEquip1.image.countTxt.text = "" + _loc_10.q_material_num_01;
            this._baoshiEquip2.image.countTxt.text = "" + _loc_10.q_material_num_02;
            this._baoshiEquip3.image.countTxt.text = "" + _loc_10.q_material_num_03;
            var _loc_14:* = VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv);
            if (!VipStrengCfgObj.getInstance().getVipStrengInfo(this._equipInfo.intensify, this._equipInfo.q_equip_steplv))
            {
                SimpleTip.show(LanguageCfgObj.getInstance().getByIndex("10623"), 3000);
                return;
            }
            var _loc_15:* = UserObj.getInstance().playerInfo.vipid;
            var _loc_16:* = _loc_10.q_streng_show_pby / 100 < 100 && _loc_15 > 0 && int(_loc_14.q_vip_level) != -1;
            if (_loc_10.q_streng_show_pby / 100 < 100 && _loc_15 > 0 && int(_loc_14.q_vip_level) != -1)
            {
                this.updateState();
            }
            else
            {
                this.btn_rate.visible = false;
                this.btn_backRate.visible = false;
                this.btn_successStreng.visible = false;
                this.btn_streng.visible = true;
                this.vipState = 1;
            }
            if (this.vipState == 2)
            {
                this.img_successRate.setNumber("100%", 44);
            }
            else
            {
                this.img_successRate.setNumber(int(_loc_10.q_streng_show_pby / 100) + "%", 44);
            }
            var _loc_17:* = _loc_14.q_vip_level;
            var _loc_18:* = _loc_15 >= _loc_17 ? ("<font color=\'#00cc33\'>" + LanguageCfgObj.getInstance().getByIndex("12019") + "</font>") : ("<font color=\'#d20404\'>" + LanguageCfgObj.getInstance().getByIndex("12020") + "</font>");
            var _loc_19:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12021"), [this._equipInfo.intensify, _loc_17, _loc_18]);
            StringTip.create(this.btn_rate, _loc_19);
            var _loc_20:* = UserObj.getInstance().playerInfo.gold < int(_loc_14.q_diamond) ? (16711680) : (16777215);
            this.txt_needMoneyValue.textColor = _loc_20;
            if (_loc_14.q_privilege_show != "")
            {
                _loc_24 = int(_loc_14.q_privilege_show) - int(_loc_14.q_diamond);
                _loc_25 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12022"), [_loc_24]);
                _loc_26 = Math.ceil(int(_loc_14.q_diamond) * 100 / int(_loc_14.q_privilege_show)) + 0;
                this.txt_needMoneyValue.text = "" + _loc_14.q_diamond + "(" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12023"), [_loc_26 / 10]) + ")";
            }
            else
            {
                _loc_25 = LanguageCfgObj.getInstance().getByIndex("10680");
                this.txt_needMoneyValue.text = "" + _loc_14.q_diamond;
            }
            var _loc_27:* = int(_loc_14.q_diamond) > 0 && this.vipState == 2;
            this.txt_needMoneyValue.visible = int(_loc_14.q_diamond) > 0 && this.vipState == 2;
            this.mc_diamond.visible = _loc_27;
            this.txt_needMoney.visible = _loc_27;
            _loc_19 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12024"), [this._equipInfo.intensify, _loc_17, _loc_18]);
            StringTip.create(this.btn_successStreng, _loc_19);
            return;
        }// end function

        public function playSelectEffect() : void
        {
            if (this._selectVmcView == null)
            {
                this._selectVmcView = new VMCView();
                this._selectVmcView.auto = true;
                this._selectVmcView.loadRes("res/effect/strengBox.png");
            }
            if (this._selectVmcView.parent == null)
            {
                this.mc_CurEquip.addChild(this._selectVmcView);
            }
            this._selectVmcView.updatePose("90", false, false, true);
            this._selectVmcView.move(28, 28);
            this._selectVmcView.play();
            return;
        }// end function

        private function showProcess() : void
        {
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_1:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.addAttributLevel + 1));
            if (!_loc_1)
            {
                return;
            }
            this._curImage.setInfo(this._equipInfo, false, "res/effect/skillbox.png");
            var _loc_2:* = this._equipInfo.cloneEquip();
            (_loc_2.addAttributLevel + 1);
            _loc_2.setAttributeEquipStrengCfg(_loc_2.intensify, _loc_2.addAttributLevel);
            this._preImage.setInfo(_loc_2, false, "res/effect/skillbox.png");
            this.scorePanel.visible = true;
            this.scorePanel.setNumber("" + this._equipInfo.fightNumber, 3, -5);
            this.scorePanel.setAddedNumber("" + (_loc_2.fightNumber - this._equipInfo.fightNumber), 5, -5);
            var _loc_3:* = PropUtil.getEquipNameAndColor(_loc_2);
            var _loc_4:* = _loc_3[0].split("  ");
            var _loc_5:* = 0;
            while (_loc_5 < (_loc_4.length - 1))
            {
                
                this["txt_name" + (_loc_5 + 1)].visible = true;
                this["txt_name" + (_loc_5 + 1)].htmlText = _loc_4[_loc_5];
                _loc_5++;
            }
            var _loc_6:* = _loc_5;
            while (_loc_6 <= (_loc_4.length - 1))
            {
                
                this["txt_name" + (_loc_6 + 1)].visible = false;
                _loc_6++;
            }
            var _loc_21:* = _loc_3[1];
            this.txt_name3.textColor = _loc_3[1];
            this.txt_name2.textColor = _loc_21;
            this.txt_name1.textColor = _loc_21;
            if (this.check_btn.selected)
            {
                _loc_16 = BackpackObj.getInstance().getItemNotBindCount(_loc_1.q_material_id_01);
                _loc_17 = BackpackObj.getInstance().getItemNotBindCount(_loc_1.q_material_id_02);
                _loc_18 = BackpackObj.getInstance().getItemNotBindCount(_loc_1.q_material_id_03);
            }
            else
            {
                _loc_16 = BackpackObj.getInstance().getItemCount(_loc_1.q_material_id_01);
                _loc_17 = BackpackObj.getInstance().getItemCount(_loc_1.q_material_id_02);
                _loc_18 = BackpackObj.getInstance().getItemCount(_loc_1.q_material_id_03);
            }
            this._baoshiEquip1.setInfo(PropUtil.createItemByCfg(_loc_1.q_material_id_01), false, "", 40, 40);
            this.baoshi1.visible = true;
            if (_loc_1.q_material_id_02)
            {
                _loc_19 = ItemCfgObj.getInstance().getCfgBy(_loc_1.q_material_id_02).q_name;
            }
            if (_loc_1.q_material_id_03)
            {
                _loc_20 = ItemCfgObj.getInstance().getCfgBy(_loc_1.q_material_id_03).q_name;
            }
            var _loc_7:* = _loc_16 < _loc_1.q_material_num_01 ? (16711680) : (16777215);
            var _loc_8:* = _loc_17 < _loc_1.q_material_num_02 ? (16711680) : (16777215);
            var _loc_9:* = _loc_18 < _loc_1.q_material_num_03 ? (16711680) : (16777215);
            var _loc_10:* = UserObj.getInstance().playerInfo.money < _loc_1.q_streng_money ? (16711680) : (16777215);
            this._baoshiEquip1.image.countTxt.textColor = _loc_7;
            this._baoshiEquip2.image.countTxt.textColor = _loc_8;
            this._baoshiEquip3.image.countTxt.textColor = _loc_9;
            this._baoshiEquip1.image.countTxt.text = "" + _loc_1.q_material_num_01;
            this._baoshiEquip2.image.countTxt.text = "" + _loc_1.q_material_num_02;
            this._baoshiEquip3.image.countTxt.text = "" + _loc_1.q_material_num_03;
            this.txt_needMoneyValue.textColor = _loc_10;
            this.txt_needMoneyValue.text = "" + ToolKit.getMoneyString(_loc_1.q_streng_money);
            this.img_successRate.setNumber(int(_loc_1.q_streng_show_pby / 100) + "%", 44);
            var _loc_11:* = [];
            var _loc_12:* = [];
            var _loc_13:* = 0;
            var _loc_14:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + this._equipInfo.addAttributLevel);
            var _loc_15:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.addAttributLevel + 1));
            if (_loc_1.q_max_physicattack)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12025") + (_loc_14 ? (_loc_14.q_max_physicattack) : (""));
                _loc_12[_loc_13] = _loc_15.q_max_physicattack - (_loc_14 ? (_loc_14.q_max_physicattack) : (0));
                _loc_13++;
            }
            if (_loc_15.q_max_magicattack)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12026") + (_loc_14 ? (_loc_14.q_max_magicattack) : (""));
                _loc_12[_loc_13] = _loc_15.q_max_magicattack - (_loc_14 ? (_loc_14.q_max_magicattack) : (0));
                _loc_13++;
            }
            if (_loc_15.q_physicattack_Percent)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12027") + (_loc_14 ? (_loc_14.q_physicattack_Percent) : (""));
                _loc_12[_loc_13] = _loc_15.q_physicattack_Percent - (_loc_14 ? (_loc_14.q_physicattack_Percent) : (0));
                _loc_13++;
            }
            if (_loc_15.q_magicattack_Percent)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12028") + (_loc_14 ? (_loc_14.q_magicattack_Percent) : (""));
                _loc_12[_loc_13] = _loc_15.q_magicattack_Percent - (_loc_14 ? (_loc_14.q_magicattack_Percent) : (0));
                _loc_13++;
            }
            if (_loc_15.q_defence)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12029") + (_loc_14 ? (_loc_14.q_defence) : (""));
                _loc_12[_loc_13] = _loc_15.q_defence - (_loc_14 ? (_loc_14.q_defence) : (0));
                _loc_13++;
            }
            if (_loc_15.q_hit)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12030") + (_loc_14 ? (_loc_14.q_hit) : (""));
                _loc_12[_loc_13] = _loc_15.q_hit - (_loc_14 ? (_loc_14.q_hit) : (0));
                _loc_13++;
            }
            if (_loc_15.q_dodge)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12031") + (_loc_14 ? (_loc_14.q_dodge) : (""));
                _loc_12[_loc_13] = _loc_15.q_dodge - (_loc_14 ? (_loc_14.q_dodge) : (0));
                _loc_13++;
            }
            if (_loc_15.q_max_hp)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12032") + (_loc_14 ? (_loc_14.q_max_hp) : (""));
                _loc_12[_loc_13] = _loc_15.q_max_hp - (_loc_14 ? (_loc_14.q_max_hp) : (0));
                _loc_13++;
            }
            if (_loc_15.q_max_mp)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12033") + (_loc_14 ? (_loc_14.q_max_mp) : (""));
                _loc_12[_loc_13] = _loc_15.q_max_mp - (_loc_14 ? (_loc_14.q_max_mp) : (0));
                _loc_13++;
            }
            if (_loc_15.q_attackspeed)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12034") + (_loc_14 ? (_loc_14.q_attackspeed) : (""));
                _loc_12[_loc_13] = _loc_15.q_attackspeed - (_loc_14 ? (_loc_14.q_attackspeed) : (0));
                _loc_13++;
            }
            if (_loc_15.q_speed)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12035") + (_loc_14 ? (_loc_14.q_speed) : (""));
                _loc_12[_loc_13] = _loc_15.q_speed - (_loc_14 ? (_loc_14.q_speed) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_attack1)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12036") + (_loc_14 ? (_loc_14.q_element_attack1) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_attack1 - (_loc_14 ? (_loc_14.q_element_attack1) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_attack2)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12037") + (_loc_14 ? (_loc_14.q_element_attack2) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_attack2 - (_loc_14 ? (_loc_14.q_element_attack2) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_attack3)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12038") + (_loc_14 ? (_loc_14.q_element_attack3) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_attack3 - (_loc_14 ? (_loc_14.q_element_attack3) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_defence1)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12039") + (_loc_14 ? (_loc_14.q_element_defence1) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_defence1 - (_loc_14 ? (_loc_14.q_element_defence1) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_defence2)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12040") + (_loc_14 ? (_loc_14.q_element_defence2) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_defence2 - (_loc_14 ? (_loc_14.q_element_defence2) : (0));
                _loc_13++;
            }
            if (_loc_15.q_element_defence3)
            {
                _loc_11[_loc_13] = LanguageCfgObj.getInstance().getByIndex("12041") + (_loc_14 ? (_loc_14.q_element_defence3) : (""));
                _loc_12[_loc_13] = _loc_15.q_element_defence3 - (_loc_14 ? (_loc_14.q_element_defence3) : (0));
                _loc_13++;
            }
            this.attributeDetailPanel.visible = true;
            this.attributeDetailPanel.setAttribute(_loc_11, _loc_12, false);
            return;
        }// end function

        private function showLuckAttr() : void
        {
            var _loc_12:* = 0;
            this._curImage.setInfo(this._equipInfo, false, "res/effect/skillbox.png");
            var _loc_1:* = this._equipInfo.cloneEquip() as EquipmentInfo;
            _loc_1.intensify = _loc_1.intensify;
            _loc_1.knowing_attackpercent = 500;
            this._preImage.setInfo(_loc_1, false, "res/effect/skillbox.png");
            this.scorePanel.visible = false;
            var _loc_2:* = PropUtil.getEquipNameAndColor(_loc_1);
            var _loc_3:* = _loc_2[0].split("  ");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                this["txt_name" + (_loc_4 + 1)].visible = true;
                this["txt_name" + (_loc_4 + 1)].htmlText = _loc_3[_loc_4];
                _loc_4++;
            }
            var _loc_5:* = _loc_4;
            while (_loc_5 <= (_loc_3.length - 1))
            {
                
                this["txt_name" + (_loc_5 + 1)].visible = false;
                _loc_5++;
            }
            var _loc_13:* = _loc_2[1];
            this.txt_name3.textColor = _loc_2[1];
            this.txt_name2.textColor = _loc_13;
            this.txt_name1.textColor = _loc_13;
            if (this.check_btn.selected)
            {
                _loc_12 = BackpackObj.getInstance().getItemNotBindCount(LuckStoneCfg.LUCK_STONE_ID);
            }
            else
            {
                _loc_12 = BackpackObj.getInstance().getItemCount(LuckStoneCfg.LUCK_STONE_ID);
            }
            var _loc_6:* = PropUtil.createItemByCfg(LuckStoneCfg.LUCK_STONE_ID);
            this._baoshiEquip1.setInfo(_loc_6, false, "", 40, 40);
            this._baoshiEquip1.image.countTxt.text = "1";
            this._baoshiEquip1.image.countTxt.textColor = _loc_12 > 0 ? (16771767) : (16711680);
            this.baoshi1.visible = true;
            var _loc_7:* = [];
            var _loc_8:* = [];
            var _loc_9:* = 0;
            var _loc_10:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + this._equipInfo.addAttributLevel);
            var _loc_11:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this._equipInfo.itemModelId + "_" + (this._equipInfo.addAttributLevel + 1));
            _loc_7[_loc_9] = "<font color=\'#00c0ff\'>" + LanguageCfgObj.getInstance().getByIndex("12042") + "</font>";
            _loc_8[_loc_9] = 0;
            _loc_9++;
            this.attributeDetailPanel.visible = false;
            return;
        }// end function

        private function getSuitCfg(param1:String) : Object
        {
            var _loc_7:* = null;
            var _loc_2:* = {};
            var _loc_3:* = param1.split(",");
            var _loc_4:* = [];
            var _loc_5:* = _loc_3 ? (_loc_3.length) : (0);
            var _loc_6:* = 0;
            while (_loc_6 < 3)
            {
                
                _loc_7 = _loc_3[_loc_6];
                _loc_4 = _loc_7 ? (_loc_7.split("_")) : ([]);
                _loc_2["q_material_id_0" + (_loc_6 + 1)] = int(_loc_4[0]);
                _loc_2["q_material_num_0" + (_loc_6 + 1)] = int(_loc_4[1]);
                _loc_6++;
            }
            return _loc_2;
        }// end function

        private function showSuit(param1:int) : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            if (this._equipInfo == null)
            {
                this.suitPanel.clear(this._type);
                return;
            }
            var _loc_2:* = this._equipInfo.suitId;
            if (_loc_2 == 0 || param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE)
            {
                _loc_2 = this._equipInfo.getNextSuitId(_loc_2);
            }
            var _loc_3:* = this.getSuitCfg(this._equipInfo.getSuit_convert_consumeBySuitId(_loc_2));
            this._curImage.setInfo(this._equipInfo, false, "res/effect/skillbox.png");
            var _loc_4:* = SuitCfgObj.instance.getSuitById(_loc_2);
            var _loc_5:* = this._equipInfo.cloneEquip();
            _loc_5.intensify = _loc_5.intensify;
            _loc_5.suitId = _loc_2;
            this._preImage.setInfo(_loc_5, false, "res/effect/skillbox.png");
            this.suitPanel.updateInfo(_loc_5, param1);
            this.scorePanel.visible = true;
            this.scorePanel.setNumber("" + this._equipInfo.fightNumber, 3, -5);
            this.scorePanel.setAddedNumber("" + _loc_4.q_score, 5, -5);
            this.txt_name1.visible = true;
            this.txt_name1.text = PropUtil.getEquipName(_loc_5, false);
            this.txt_name1.textColor = PropUtil.getEquipColor(_loc_5);
            this.txt_name2.visible = false;
            this.txt_name3.visible = false;
            if (this.check_btn.selected)
            {
                _loc_10 = BackpackObj.getInstance().getItemNotBindCount(_loc_3.q_material_id_01);
                _loc_11 = BackpackObj.getInstance().getItemNotBindCount(_loc_3.q_material_id_02);
                _loc_12 = BackpackObj.getInstance().getItemNotBindCount(_loc_3.q_material_id_03);
            }
            else
            {
                _loc_10 = BackpackObj.getInstance().getItemCount(_loc_3.q_material_id_01);
                _loc_11 = BackpackObj.getInstance().getItemCount(_loc_3.q_material_id_02);
                _loc_12 = BackpackObj.getInstance().getItemCount(_loc_3.q_material_id_03);
            }
            this._baoshiEquip1.setInfo(PropUtil.createItemByCfg(_loc_3.q_material_id_01), false, "", 40, 40);
            this.baoshi1.visible = true;
            if (_loc_3.q_material_id_02)
            {
                this._baoshiEquip2.setInfo(PropUtil.createItemByCfg(_loc_3.q_material_id_02), false, "", 40, 40);
                this.baoshi2.visible = true;
            }
            else
            {
                this.baoshi2.visible = false;
            }
            if (_loc_3.q_material_id_03)
            {
                this._baoshiEquip3.setInfo(PropUtil.createItemByCfg(_loc_3.q_material_id_03), false, "", 40, 40);
                this.baoshi3.visible = true;
            }
            else
            {
                this.baoshi3.visible = false;
            }
            var _loc_6:* = _loc_10 < _loc_3.q_material_num_01 ? (16711680) : (16777215);
            var _loc_7:* = _loc_11 < _loc_3.q_material_num_02 ? (16711680) : (16777215);
            var _loc_8:* = _loc_12 < _loc_3.q_material_num_03 ? (16711680) : (16777215);
            var _loc_9:* = UserObj.getInstance().playerInfo.money < _loc_3.q_streng_money ? (16711680) : (16777215);
            this._baoshiEquip1.image.countTxt.textColor = _loc_6;
            this._baoshiEquip2.image.countTxt.textColor = _loc_7;
            this._baoshiEquip3.image.countTxt.textColor = _loc_8;
            this._baoshiEquip1.image.countTxt.text = "" + _loc_3.q_material_num_01;
            this._baoshiEquip2.image.countTxt.text = "" + _loc_3.q_material_num_02;
            this._baoshiEquip3.image.countTxt.text = "" + _loc_3.q_material_num_03;
            this.attributeDetailPanel.visible = false;
            return;
        }// end function

        private function suitSplitPlayEffect(param1:EquipmentInfo, param2:Object) : void
        {
            var _loc_3:* = null;
            if (param2.suitId)
            {
                return;
            }
            if (this._baoshiEquip1 && this._baoshiEquip1.visible && this._baoshiEquip1.info)
            {
                _loc_3 = this._baoshiEquip1.localToGlobal(new Point(0, 0));
                ItemGetAnim.doFlyToBackPack(this._baoshiEquip1.info.itemModelId, _loc_3);
            }
            if (this._baoshiEquip2 && this._baoshiEquip2.visible && this._baoshiEquip2.info)
            {
                _loc_3 = this._baoshiEquip2.localToGlobal(new Point(0, 0));
                ItemGetAnim.doFlyToBackPack(this._baoshiEquip2.info.itemModelId, _loc_3);
            }
            if (this._baoshiEquip3 && this._baoshiEquip3.visible && this._baoshiEquip3.info)
            {
                _loc_3 = this._baoshiEquip3.localToGlobal(new Point(0, 0));
                ItemGetAnim.doFlyToBackPack(this._baoshiEquip3.info.itemModelId, _loc_3);
            }
            return;
        }// end function

        private function showSuitSplit(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            if (this._equipInfo == null)
            {
                this.suitPanel.clear(this._type);
                return;
            }
            var _loc_2:* = this._equipInfo.q_suit_convert_ids.indexOf(this._equipInfo.suitId);
            var _loc_3:* = new Object();
            var _loc_4:* = 0;
            while (_loc_4 <= _loc_2)
            {
                
                _loc_9 = int(this._equipInfo.q_suit_convert_ids[_loc_4]);
                _loc_10 = this._equipInfo.getSuit_convert_consumeBySuitId(_loc_9);
                _loc_11 = _loc_10.split(",");
                _loc_12 = _loc_11 ? (_loc_11.length) : (0);
                _loc_13 = 0;
                while (_loc_13 < _loc_12)
                {
                    
                    _loc_14 = _loc_11[_loc_13];
                    _loc_15 = _loc_14 ? (_loc_14.split("_")) : ([]);
                    if (!_loc_3["q_material_id_0" + (_loc_13 + 1)])
                    {
                        _loc_3["q_material_id_0" + (_loc_13 + 1)] = 0;
                        _loc_3["q_material_num_0" + (_loc_13 + 1)] = 0;
                    }
                    _loc_3["q_material_id_0" + (_loc_13 + 1)] = int(_loc_15[0]);
                    _loc_3["q_material_num_0" + (_loc_13 + 1)] = _loc_3["q_material_num_0" + (_loc_13 + 1)] + int(_loc_15[1]);
                    _loc_13++;
                }
                _loc_4++;
            }
            if (_loc_3.q_material_id_01)
            {
                _loc_5 = PropUtil.createItemByCfg(_loc_3.q_material_id_01);
                _loc_5.isbind = this._equipInfo.isbind;
                this._baoshiEquip1.setInfo(_loc_5, false, "", 40, 40);
                _loc_16 = _loc_3.q_material_num_01;
                this.baoshi1.visible = true;
                this.txt_SplitStone1.visible = false;
            }
            else
            {
                this.baoshi1.visible = false;
                this._baoshiEquip1.setInfo(null);
                this.txt_SplitStone1.visible = true;
            }
            if (_loc_3.q_material_id_02)
            {
                _loc_5 = PropUtil.createItemByCfg(_loc_3.q_material_id_02);
                _loc_5.isbind = this._equipInfo.isbind;
                this._baoshiEquip2.setInfo(_loc_5, false, "", 40, 40);
                _loc_17 = _loc_3.q_material_num_01;
                this.baoshi2.visible = true;
                this.txt_SplitStone2.visible = false;
            }
            else
            {
                this.baoshi2.visible = false;
                this._baoshiEquip2.setInfo(null);
                this.txt_SplitStone2.visible = true;
            }
            if (this._equipInfo.suitId)
            {
                _loc_18 = this._equipInfo.cloneEquip();
                _loc_18.suitId = 0;
                _loc_18.isbind = this._equipInfo.isbind;
                this._baoshiEquip3.setInfo(_loc_18, false, "", 40, 40);
                _loc_19 = SuitCfgObj.instance.getSuitById(this._equipInfo.suitId);
                this.txt_SuitSplitCost.text = ToolKit.getUintStr(_loc_19.q_split_coin);
                this.txt_SuitSplitCost.textColor = UserObj.getInstance().playerInfo.money < _loc_19.q_split_coin ? (16711680) : (16777215);
                this.baoshi3.visible = true;
                this.txt_SplitEquip2.visible = false;
            }
            else
            {
                this.txt_SuitSplitCost.text = "";
                this.baoshi3.visible = false;
                this._baoshiEquip3.setInfo(null);
                this.txt_SplitEquip2.visible = true;
            }
            var _loc_6:* = 16777215;
            var _loc_7:* = 16777215;
            var _loc_8:* = 16777215;
            this._baoshiEquip1.image.countTxt.textColor = _loc_6;
            this._baoshiEquip2.image.countTxt.textColor = _loc_7;
            this._baoshiEquip3.image.countTxt.textColor = _loc_8;
            this._baoshiEquip1.image.countTxt.text = "" + _loc_3.q_material_num_01;
            this._baoshiEquip2.image.countTxt.text = "" + _loc_3.q_material_num_02;
            this._baoshiEquip3.image.countTxt.text = "";
            this.attributeDetailPanel.visible = false;
            if (this._equipInfo.suitId)
            {
                this._curImage.setInfo(this._equipInfo);
                this.txt_SplitEquip1.visible = false;
            }
            else
            {
                this._curImage.setInfo(null);
                this.txt_SplitEquip1.visible = true;
                this._equipInfo = null;
            }
            return;
        }// end function

        private function setSuitSplitUI() : void
        {
            this._curImage.x = -108 + 7;
            this._curImage.y = 20 + 11;
            this._baoshiEquip1.x = 8 + 8;
            this._baoshiEquip1.y = -70 - 101;
            this._baoshiEquip2.x = -140 - 8;
            this._baoshiEquip2.y = -232 + 192;
            this._baoshiEquip3.x = -291 + 6;
            this._baoshiEquip3.y = -72 - 101;
            this.btn_StartSplit.visible = true;
            this.suitSplitView.visible = true;
            this.btn_streng.visible = false;
            return;
        }// end function

        private function resetSuitSplitUI() : void
        {
            this._curImage.x = 0;
            this._curImage.y = 0;
            this._baoshiEquip1.x = 0;
            this._baoshiEquip1.y = 0;
            this._baoshiEquip2.x = 0;
            this._baoshiEquip2.y = 0;
            this._baoshiEquip3.x = 0;
            this._baoshiEquip3.y = 0;
            this.btn_StartSplit.visible = false;
            this.suitSplitView.visible = false;
            this.btn_streng.visible = true;
            this.txt_SuitSplitCost.text = "";
            return;
        }// end function

        private function playEffect() : void
        {
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            var _loc_1:* = MovieClip(this.mc_effect.getChildByName("mc_effect"));
            _loc_1.play();
            _loc_1.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = event.target as MovieClip;
            if (_loc_2.currentFrame == _loc_2.totalFrames)
            {
                this.send();
            }
            return;
        }// end function

        private function playFireEffect() : void
        {
            this.mc_effectFire.play();
            return;
        }// end function

        private function playEffectProcess() : void
        {
            this.playEffect();
            return;
        }// end function

        private function playFireEffectProcess() : void
        {
            this.playFireEffect();
            return;
        }// end function

        private function playLevelFireEffect() : void
        {
            var strengLevel:int;
            var j:int;
            var i:int;
            var count:int;
            var k:int;
            if (this._equipInfo)
            {
                strengLevel = this._equipInfo.intensify;
                if (this._videoLevelFireVmcView == null)
                {
                    i;
                    while (i < 16)
                    {
                        
                        this._videoLevelFireVmcView = new VMCView();
                        this._videoLevelFireVmcView.loadRes("res/effect/ui_fire_a.png");
                        this._videoLevelFireVmcView.auto = true;
                        if (this._videoLevelFireVmcView.parent == null)
                        {
                            MovieClip(this.fireMcArray[i]).addChild(this._videoLevelFireVmcView);
                        }
                        this._fireVmcArray.push(this._videoLevelFireVmcView);
                        i = (i + 1);
                    }
                    count;
                    k;
                    while (k < this._fireVmcArray.length)
                    {
                        
                        TweenLite.delayedCall(k * 0.15, function () : void
            {
                _fireVmcArray[count].updatePose("90", true);
                _fireVmcArray[count].play();
                var _loc_2:* = count + 1;
                count = _loc_2;
                return;
            }// end function
            );
                        k = (k + 1);
                    }
                }
                j;
                while (j < this._fireVmcArray.length)
                {
                    
                    if (j < strengLevel)
                    {
                        this._fireVmcArray[j].visible = true;
                        this._fireVmcArray[j].play();
                    }
                    else
                    {
                        this._fireVmcArray[j].visible = false;
                        this._fireVmcArray[j].stop();
                    }
                    j = (j + 1);
                }
            }
            return;
        }// end function

        private function playLevelFireEffect2() : void
        {
            var strengLevel:int;
            var j:int;
            var i:int;
            var count:int;
            var k:int;
            if (this._equipInfo)
            {
                strengLevel = this._equipInfo.addAttributLevel;
                if (this._videoLevelFireVmcView2 == null)
                {
                    i;
                    while (i < 16)
                    {
                        
                        this._videoLevelFireVmcView2 = new VMCView();
                        this._videoLevelFireVmcView2.loadRes("res/effect/ui_fire_b.png");
                        this._videoLevelFireVmcView2.auto = true;
                        if (this._videoLevelFireVmcView2.parent == null)
                        {
                            MovieClip(this.fireMcArray2[i]).addChild(this._videoLevelFireVmcView2);
                        }
                        this._fireVmcArray2.push(this._videoLevelFireVmcView2);
                        i = (i + 1);
                    }
                    count;
                    k;
                    while (k < this._fireVmcArray2.length)
                    {
                        
                        TweenLite.delayedCall(k * 0.15, function () : void
            {
                _fireVmcArray2[count].updatePose("90", true);
                _fireVmcArray2[count].play();
                var _loc_2:* = count + 1;
                count = _loc_2;
                return;
            }// end function
            );
                        k = (k + 1);
                    }
                }
                j;
                while (j < this._fireVmcArray2.length)
                {
                    
                    if (j < strengLevel)
                    {
                        this._fireVmcArray2[j].visible = true;
                        this._fireVmcArray2[j].play();
                    }
                    else
                    {
                        this._fireVmcArray2[j].visible = false;
                        this._fireVmcArray2[j].stop();
                    }
                    j = (j + 1);
                }
            }
            return;
        }// end function

        private function playerSuccessFailEffect(param1:String, param2:Number = 0, param3:Number = 0) : void
        {
            var _loc_4:* = null;
            if (_loc_4 == null)
            {
                _loc_4 = new VMCView();
                _loc_4.auto = true;
            }
            _loc_4.loadRes(param1);
            if (_loc_4.parent == null)
            {
                this.tipsImg.addChild(_loc_4);
            }
            _loc_4.updatePose("90", false, false, true);
            _loc_4.move(85 + param2, 95 + param3);
            _loc_4.play();
            return;
        }// end function

        private function playTips(param1:String) : void
        {
            if (!this.tipsImage)
            {
                this.tipsImage = new Image();
                this.tipsImg.addChild(this.tipsImage);
            }
            this.tipsImage.load(param1);
            TweenLite.delayedCall(2, this.remove);
            return;
        }// end function

        private function remove(event:Event = null) : void
        {
            if (this.tipsImage)
            {
                this.tipsImage.dispose();
            }
            return;
        }// end function

        private function closeLoading(event:Event = null) : void
        {
            EquipForgeControl.getInstance().equipForgeBox.closeLoading();
            return;
        }// end function

        private function updateEnabled(param1:Boolean) : void
        {
            if (!param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this.btn_successStreng);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn_successStreng);
            }
            this.btn_streng.enabled = !param1;
            this.btn_successStreng.enabled = !param1;
            return;
        }// end function

        override public function finalize() : void
        {
            this._curImage.setInfo(null);
            this._preImage.setInfo(null);
            this._list.reset();
            super.finalize();
            return;
        }// end function

        public function get equipInfo() : EquipmentInfo
        {
            return this._equipInfo;
        }// end function

    }
}
