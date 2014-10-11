package com.game.equipstreng.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.ui.tree.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.model.*;
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.message.bean.*;
    import com.game.equipstreng.model.*;
    import com.game.guide.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.player.model.*;
    import com.game.protect.control.*;
    import com.game.sound.control.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class EquipComposeBox extends BaseBox implements IGuide
    {
        private var _list:List;
        private var _listItem:TreeItem;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var tree:Tree;
        private var curCompose_id:int;
        private var cur_use_not_sign_item:String;
        private var cur_use_not_sign_item_id:String;
        private var cur_Q_Nonfinite_item:String;
        private var cur_Cfg:Object;
        private var hasInit:Boolean = false;
        private var lastClickItem:EquipComposeItem;
        private var saveEquipID:long;
        private var mc_List:MovieClip;
        private var closeBtn:BaseButton;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var img1:MovieClip;
        private var img2:MovieClip;
        private var img3:MovieClip;
        private var img4:MovieClip;
        private var img5:MovieClip;
        private var img6:MovieClip;
        private var img7:MovieClip;
        private var btn_equip:MovieClip;
        private var equipImageFactory:Array;
        private var equipImageWing:Array;
        private var equipImage:EquipImage;
        private var btn_Compose:BaseButton;
        private var check_btn:BaseButton;
        private var wingImg1:MovieClip;
        private var wingImg2:MovieClip;
        private var wingImg3:MovieClip;
        private var wingImg4:MovieClip;
        private var wingImg5:MovieClip;
        private var wingImg6:MovieClip;
        private var wingImg7:MovieClip;
        private var wingImg8:MovieClip;
        private var wingImg9:MovieClip;
        private var wingImg10:MovieClip;
        private var wingImg11:MovieClip;
        private var wingImg12:MovieClip;
        private var txt_money_need:TextField;
        private var txt_diamond_need:TextField;
        private var txt_success_percent:TextField;
        private var txt_wingMataril:TextField;
        private var mc_warning:MovieClip;
        private var txt_warning:TextField;
        private var tipsImg:MovieClip;
        private var curNeed:Boolean = false;
        private var _composeEffect:VMCView;
        private var tipsImage:Image;
        private var _vec:Vector.<EquipmentInfo>;
        private var _selectItemName:String = "";
        private var btnArray:Array;
        private var btnName:Array;
        private var cur_selectIndex:int = 0;
        private var curPage:int = 1;
        private var count:int = 0;
        private var _needAutoClick:Boolean;
        private var hasBind:Boolean = false;
        private var hasOpenTipsDay:Boolean = false;

        public function EquipComposeBox()
        {
            this.saveEquipID = new long(0, 0);
            this.equipImageFactory = [];
            this.equipImageWing = [];
            this.btnArray = [];
            this.btnName = [LanguageCfgObj.getInstance().getByIndex("11686"), LanguageCfgObj.getInstance().getByIndex("11687"), LanguageCfgObj.getInstance().getByIndex("11688"), LanguageCfgObj.getInstance().getByIndex("11960")];
            _combinedBox = ["com.game.equipstreng.view::ComposeEquipSelectBox"];
            loadDisplay("res/equipCompose.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("equipCompose");
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.registerGuide();
            return;
        }// end function

        private function initUI() : void
        {
            this.tree = new Tree(152, 430);
            this.tree.scroll.visible = false;
            this.mc_List = getDisplayChildByName("mc_List");
            this.mc_List.addChild(this.tree);
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn1.selected = true;
            this.btnArray.push(this.btn1, this.btn2, this.btn3, this.btn4);
            var _loc_1:* = 0;
            while (_loc_1 < this.btnName.length)
            {
                
                this["btn" + (_loc_1 + 1)].setText(this.btnName[_loc_1]);
                _loc_1++;
            }
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc1.visible = false;
            var _loc_2:* = 0;
            while (_loc_2 < 3)
            {
                
                this["img" + (_loc_2 + 1)] = this.mc1.getChildByName("img" + (_loc_2 + 1));
                this["img" + (_loc_2 + 1)].txt.mouseEnabled = false;
                _loc_2++;
            }
            _loc_2 = 3;
            while (_loc_2 < 7)
            {
                
                this["img" + (_loc_2 + 1)] = getDisplayChildByName("img" + (_loc_2 + 1) + "1");
                _loc_2++;
            }
            this.btn_equip = this.mc1.getChildByName("btn_equip") as MovieClip;
            _loc_2 = 0;
            while (_loc_2 < 12)
            {
                
                this["wingImg" + (_loc_2 + 1)] = this.mc2.getChildByName("wingImg" + (_loc_2 + 1)) as MovieClip;
                this["wingImg" + (_loc_2 + 1)].txt.mouseEnabled = false;
                this["wingImg" + (_loc_2 + 1)].mc_mask.mouseEnabled = false;
                _loc_2++;
            }
            this.txt_money_need = getDisplayChildByName("txt_money_need");
            this.txt_diamond_need = getDisplayChildByName("txt_diamond_need");
            this.txt_success_percent = getDisplayChildByName("txt_success_percent");
            this.txt_wingMataril = this.mc2.getChildByName("txt_wingMataril") as TextField;
            this.mc_warning = getDisplayChildByName("mc_warning1");
            this.txt_warning = getDisplayChildByName("txt_warning");
            this.btn_Compose = new BaseButton(getDisplayChildByName("btn_Compose"));
            this.btn_Compose.setText(LanguageCfgObj.getInstance().getByIndex("10604"));
            this.check_btn = new BaseButton(getDisplayChildByName("check_btn"));
            this.check_btn.setText(LanguageCfgObj.getInstance().getByIndex("10605"));
            this.check_btn.addEventListener(MouseEvent.CLICK, this.clickCheckBtn);
            this.tipsImg = getDisplayChildByName("tipsImg");
            var _loc_3:* = 0;
            while (_loc_3 < 7)
            {
                
                this.equipImage = new EquipImage();
                this["img" + (_loc_3 + 1)].mc_empty.addChild(this.equipImage);
                this.equipImageFactory.push(this.equipImage);
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < 12)
            {
                
                this.equipImage = new EquipImage();
                this["wingImg" + (_loc_3 + 1)].mc_empty.addChild(this.equipImage);
                this.equipImageWing.push(this.equipImage);
                _loc_3++;
            }
            this.btn_equip.gotoAndStop(1);
            this.img1.mc_mask.mouseEnabled = false;
            this.img2.mc_mask.mouseEnabled = false;
            this.img3.mc_mask.mouseEnabled = false;
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.btn_Compose.addEventListener("click", this.send);
            this.refreshEquipComposeList();
            this.hasInit = true;
            this.clear();
            if (this._selectItemName)
            {
                this.selectItemByItemName(this._selectItemName);
            }
            return;
        }// end function

        private function clickCheckBtn(event:MouseEvent) : void
        {
            this.check_btn.selected = !this.check_btn.selected;
            return;
        }// end function

        private function addEvents() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.btnName.length)
            {
                
                this["btn" + (_loc_1 + 1)].addEventListener(MouseEvent.CLICK, this.__click);
                _loc_1++;
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            this.clear();
            switch(event.target)
            {
                case this.btn1:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_WING);
                    this.mc1.visible = false;
                    this.mc2.visible = true;
                    _loc_3 = 0;
                    while (_loc_3 < 12)
                    {
                        
                        this["wingImg" + (_loc_3 + 1)].mc_mask.visible = false;
                        _loc_3++;
                    }
                    this.curPage = 1;
                    break;
                }
                case this.btn2:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_TICKET);
                    this.mc1.visible = true;
                    this.mc2.visible = false;
                    this.curPage = 2;
                    break;
                }
                case this.btn3:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_BLOOD);
                    this.mc1.visible = true;
                    this.mc2.visible = false;
                    this.curPage = 3;
                    break;
                }
                case this.btn4:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_ANGEL);
                    this.mc1.visible = false;
                    this.mc2.visible = true;
                    this.curPage = 4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.btnArray.length)
            {
                
                if (event.target == this.btnArray[_loc_2])
                {
                    this.btnArray[_loc_2].selected = true;
                }
                else
                {
                    this.btnArray[_loc_2].selected = false;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function send(event:Event) : void
        {
            var e:* = event;
            if (this.curCompose_id != 0)
            {
                if (!this.checkCanCompose())
                {
                    return;
                }
                if (!this.check_btn.selected && this.hasBind && !this.hasOpenTipsDay)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11974"), LanguageCfgObj.getInstance().getByIndex("11635"), null, function () : void
            {
                sendMessage1();
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10606"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay = param1;
                return;
            }// end function
            );
                    return;
                }
                this.sendMessage1();
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10607"));
            }
            return;
        }// end function

        private function sendMessage1() : void
        {
            var succ:int;
            if (this.curPage == EquipForgeData.TYPE_WING)
            {
                succ = int(this.txt_success_percent.text.slice(0, (this.txt_success_percent.text.length - 1)));
                if (succ < 100)
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11975"), LanguageCfgObj.getInstance().getByIndex("11635"), null, function () : void
            {
                sendMessage2();
                return;
            }// end function
            , null, 2);
                    return;
                }
                this.sendMessage2();
            }
            else
            {
                this.sendMessage2();
            }
            return;
        }// end function

        private function sendMessage2() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            if (this.curPage == EquipForgeData.TYPE_WING)
            {
                _loc_1 = new Vector.<ComposeAddInfo>;
                _loc_2 = EquipForgeData.saveEquipIdAdd;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    if (_loc_2[_loc_3] && _loc_2[_loc_3] != this.saveEquipID)
                    {
                        _loc_4 = new ComposeAddInfo();
                        _loc_4.equip_id = _loc_2[_loc_3];
                        _loc_1.push(_loc_4);
                    }
                    _loc_3++;
                }
                EquipForgeControl.getInstance().reqEquipWingCompose(this.curCompose_id, this.check_btn.selected ? (1) : (0), this.saveEquipID, _loc_1);
            }
            else if (this.curPage == EquipForgeData.TYPE_ANGEL)
            {
                _loc_2 = EquipForgeData.saveEquipIdAdd;
                _loc_5 = new Vector.<long>;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    if (_loc_2[_loc_3])
                    {
                        _loc_5.push(_loc_2[_loc_3]);
                    }
                    _loc_3++;
                }
                if (_loc_5.length < 2 || _loc_5[0] == null || _loc_5[1] == null)
                {
                    throw new Error("物品id为空");
                }
                EquipForgeControl.getInstance().reqAngelCompose(this.curCompose_id, this.check_btn.selected ? (1) : (0), _loc_5);
            }
            else
            {
                EquipForgeControl.getInstance().reqEquipCompose(this.curCompose_id, this.check_btn.selected ? (1) : (0), this.saveEquipID);
            }
            if (BackpackObj.getInstance().getIdle() >= 1)
            {
                this.playerEffect();
            }
            EquipForgeData.saveEquipIdAdd = [];
            return;
        }// end function

        private function checkEnough(param1:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = [ItemConst.BLESS_STONE, ItemConst.SOUL_STONE, ItemConst.LIFE_STONE];
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < param1.length)
                {
                    
                    _loc_5 = param1[_loc_4].split(",");
                    _loc_6 = BackpackObj.getInstance().getItemCount(_loc_5[0]);
                    if (_loc_5[0] == _loc_2[_loc_3])
                    {
                        if (_loc_6 < _loc_5[1])
                        {
                            FunGuideControl.getInstance().checkItem(_loc_5[0]);
                            return;
                        }
                        break;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function checkCanCompose() : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_1:* = this.cur_Cfg.use_item.split(";");
            this.checkEnough(_loc_1);
            this.hasBind = false;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2].split(",");
                _loc_4 = BackpackObj.getInstance().getItemCount(_loc_3[0]);
                _loc_5 = BackpackObj.getInstance().getItemBindCount(_loc_3[0]);
                if (_loc_5)
                {
                    this.hasBind = true;
                }
                if (_loc_4 < _loc_3[1])
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10608"));
                    return false;
                }
                _loc_2++;
            }
            if (this.cur_Cfg.use_not_sign_item && this.saveEquipID.equal(new long(0, 0)))
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10608"));
                return false;
            }
            if (this.curPage == EquipForgeData.TYPE_ANGEL)
            {
                _loc_6 = 0;
                _loc_7 = EquipForgeData.saveEquipIdAdd;
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    if (_loc_7[_loc_2])
                    {
                        _loc_6++;
                    }
                    _loc_2++;
                }
                if (_loc_6 < 2)
                {
                    Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10608"));
                    return false;
                }
            }
            if (UserObj.getInstance().playerInfo.money < this.cur_Cfg.money_need)
            {
                FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10610"));
                return false;
            }
            if (UserObj.getInstance().playerInfo.gold < this.cur_Cfg.diamond_need)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10611"));
                return false;
            }
            return true;
        }// end function

        private function refreshEquipComposeList(param1:int = 1) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            this.tree.reset();
            var _loc_2:* = EquipComposeCfgObj.getInstance().getMapByType(param1);
            var _loc_3:* = new Array();
            for (_loc_4 in _loc_2)
            {
                
                _loc_7 = _loc_4.split("_");
                if (_loc_3[_loc_7[0]] == null)
                {
                    _loc_3[_loc_7[0]] = new Array();
                }
                _loc_3[_loc_7[0]][_loc_7[1]] = _loc_4;
            }
            _loc_5 = 0;
            _loc_6 = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                if (_loc_3[_loc_6])
                {
                    _loc_8 = _loc_3[_loc_6][1].lastIndexOf("_");
                    _loc_9 = _loc_3[_loc_6][1].slice((_loc_8 + 1));
                    this.tree.addTreeItem(_loc_9, 16773804, null, 6737151, false);
                    _loc_10 = 0;
                    while (_loc_10 < _loc_3[_loc_6].length)
                    {
                        
                        _loc_11 = UserObj.getInstance().playerInfo.level;
                        _loc_12 = "" + _loc_6 + "_" + _loc_10 + "_" + _loc_9;
                        if (_loc_2[_loc_12])
                        {
                            _loc_13 = int(_loc_2[_loc_12].q_level);
                        }
                        if (_loc_3[_loc_6][_loc_10] && _loc_11 >= _loc_13)
                        {
                            _loc_14 = new EquipComposeItem();
                            _loc_14.index = _loc_10;
                            _loc_14.obj = _loc_2[_loc_12];
                            _loc_14.name = _loc_12;
                            _loc_14.addEventListener(MouseEvent.CLICK, this.selectItem);
                            this.tree.addSecondItem(_loc_14, _loc_5);
                        }
                        _loc_10++;
                    }
                    _loc_5++;
                }
                _loc_6++;
            }
            this.tree.setTreeItemUnfoldByIndex(0);
            return;
        }// end function

        public function selectItemByItemName(param1:String = "恶魔广场通行证+1") : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this._selectItemName = param1;
            if (UILoaded)
            {
                _loc_2 = EquipComposeCfgObj.getInstance().getTypeByName(this._selectItemName);
                this.__click2(this["btn" + _loc_2]);
                _loc_3 = 0;
                while (_loc_3 < this.tree.length)
                {
                    
                    _loc_4 = this.tree.getTreeItemByIndex(_loc_3);
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.getItemNum())
                    {
                        
                        _loc_6 = _loc_4.getItemAt(_loc_5) as EquipComposeItem;
                        if (_loc_6.info.item_name == param1)
                        {
                            this.tree.setTreeItemFoldByIndex(0);
                            this.tree.setTreeItemUnfoldByIndex(_loc_3);
                            _loc_6.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                            return;
                        }
                        _loc_5++;
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function __click2(param1:BaseButton) : void
        {
            var _loc_3:* = 0;
            this.clear();
            switch(param1)
            {
                case this.btn1:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_WING);
                    this.mc1.visible = false;
                    this.mc2.visible = true;
                    _loc_3 = 0;
                    while (_loc_3 < 12)
                    {
                        
                        this["wingImg" + (_loc_3 + 1)].mc_mask.visible = false;
                        _loc_3++;
                    }
                    this.curPage = 1;
                    break;
                }
                case this.btn2:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_TICKET);
                    this.mc1.visible = true;
                    this.mc2.visible = false;
                    this.curPage = 2;
                    break;
                }
                case this.btn3:
                {
                    this.refreshEquipComposeList(EquipForgeData.TYPE_BLOOD);
                    this.mc1.visible = true;
                    this.mc2.visible = false;
                    this.curPage = 3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.btnArray.length)
            {
                
                if (param1 == this.btnArray[_loc_2])
                {
                    this.btnArray[_loc_2].selected = true;
                }
                else
                {
                    this.btnArray[_loc_2].selected = false;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function selectItem(event:MouseEvent, param2:int = -2) : void
        {
            if (event == null)
            {
                var _loc_3:* = this.lastClickItem.name;
                this.cur_Cfg = EquipComposeCfgObj.getInstance().getEquipComposeinfoByLev(_loc_3);
                this.curCompose_id = this.cur_Cfg.compose_id;
                this.showText(this.cur_Cfg);
                if (this.curPage == EquipForgeData.TYPE_WING)
                {
                    this.showImageWing(this.cur_Cfg);
                }
                else if (this.curPage == EquipForgeData.TYPE_ANGEL)
                {
                    this.showImageAngel(this.cur_Cfg);
                }
                else
                {
                    this.showImage(this.cur_Cfg);
                }
                this.showResultImage(this.cur_Cfg);
                if (param2 == 1)
                {
                    SoundControl.getInstance().playSound(SoundFlag.SUCCESS_COMPOS);
                    this.playerSuccessEffect(1);
                }
                else if (param2 == 0)
                {
                    SoundControl.getInstance().playSound(SoundFlag.FAILE_COMPOS);
                    this.playerSuccessEffect(2);
                }
                return;
            }
            this.cur_selectIndex = 0;
            EquipForgeData.saveEquipIdAdd = [];
            this.hasBind = false;
            _loc_3 = event.currentTarget.name;
            this.cur_Cfg = EquipComposeCfgObj.getInstance().getEquipComposeinfoByLev(_loc_3);
            this.curCompose_id = this.cur_Cfg.compose_id;
            if (this.curPage == EquipForgeData.TYPE_WING)
            {
                this.showImageWing(this.cur_Cfg);
            }
            else if (this.curPage == EquipForgeData.TYPE_ANGEL)
            {
                this.showImageAngel(this.cur_Cfg);
            }
            else
            {
                this.showImage(this.cur_Cfg);
            }
            this.showText(this.cur_Cfg);
            this.showResultImage(this.cur_Cfg);
            this.filterEquip();
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = false;
            }
            this.lastClickItem = event.currentTarget as EquipComposeItem;
            this.lastClickItem.selected = true;
            return;
        }// end function

        private function showText(param1:Object) : void
        {
            this.txt_money_need.text = ToolKit.getMoneyString(param1.money_need);
            if (UserObj.getInstance().playerInfo.money >= param1.money_need)
            {
                this.txt_money_need.textColor = 16777215;
            }
            else
            {
                this.txt_money_need.textColor = 16711680;
            }
            this.txt_diamond_need.text = param1.diamond_need;
            if (UserObj.getInstance().playerInfo.gold >= param1.diamond_need)
            {
                this.txt_diamond_need.textColor = 16777215;
            }
            else
            {
                this.txt_diamond_need.textColor = 16711680;
            }
            this.txt_success_percent.text = param1.success_percent / 100 + "%";
            return;
        }// end function

        private function showImage(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 7)
            {
                
                this.equipImageFactory[_loc_2].setInfo(null);
                _loc_2++;
            }
            var _loc_3:* = 1;
            while (_loc_3 <= 3)
            {
                
                this["img" + _loc_3].txt.text = "";
                this["img" + _loc_3].mc_mask.visible = false;
                _loc_3++;
            }
            this.cur_use_not_sign_item = "";
            this.saveEquipID = new long(0, 0);
            if (param1.use_item)
            {
                _loc_4 = [];
                _loc_5 = [];
                _loc_6 = 0;
                _loc_7 = param1.use_item.split(";");
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_10 = _loc_7[_loc_8].split(",");
                    _loc_11 = BackpackObj.getInstance().getItemCount(_loc_10[0]);
                    _loc_12 = new PropInfo();
                    _loc_12.convByCfg(_loc_10[0]);
                    _loc_12.isMine = true;
                    if (_loc_10[0] == 600003)
                    {
                        this.equipImageFactory[2].setInfo(_loc_12, false, "", 40, 40);
                        if (_loc_11 < _loc_10[1])
                        {
                            _loc_5[2] = 0;
                        }
                        else
                        {
                            _loc_5[2] = 1;
                        }
                        this["img3"].txt.text = _loc_11 + "/" + _loc_10[1];
                    }
                    else
                    {
                        _loc_4.push(_loc_12);
                        if (_loc_11 < _loc_10[1])
                        {
                            _loc_5[_loc_6] = 0;
                        }
                        else
                        {
                            _loc_5[_loc_6] = 1;
                        }
                        _loc_6++;
                        this["img" + _loc_6].txt.text = _loc_11 + "/" + _loc_10[1];
                    }
                    _loc_8++;
                }
                _loc_9 = 0;
                while (_loc_9 < _loc_4.length)
                {
                    
                    this.equipImageFactory[_loc_9].setInfo(_loc_4[_loc_9], false, "", 40, 40);
                    _loc_9++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_3] != null && _loc_5[_loc_3] == 1 || _loc_5[_loc_3] == null)
                    {
                        this["img" + (_loc_3 + 1)].mc_mask.visible = false;
                    }
                    else
                    {
                        this["img" + (_loc_3 + 1)].mc_mask.visible = true;
                    }
                    _loc_3++;
                }
            }
            this.btn_equip.gotoAndStop(5);
            if (param1.use_not_sign_item)
            {
                this.cur_use_not_sign_item = param1.use_not_sign_item;
                this.cur_use_not_sign_item_id = param1.use_not_sign_item_id;
                _loc_13 = this.cur_use_not_sign_item.split(",");
                if (param1.compose_id == 16)
                {
                    StringTip.create(this.btn_equip, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11976"), [_loc_13[2]]));
                }
                else if (param1.compose_id == 17)
                {
                    StringTip.create(this.btn_equip, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11976"), [_loc_13[2]]));
                }
                else if (param1.compose_id == 18)
                {
                    StringTip.create(this.btn_equip, LanguageCfgObj.getInstance().getByIndex("10612"));
                }
                this.btn_equip.gotoAndStop(1);
                this.curNeed = true;
                this.btn_equip.addEventListener(MouseEvent.CLICK, this.openChooseEquip);
            }
            else
            {
                this.btn_equip.removeEventListener(MouseEvent.CLICK, this.openChooseEquip);
                StringTip.dispose(this.btn_equip);
                this.btn_equip.gotoAndStop(4);
                this.curNeed = false;
            }
            return;
        }// end function

        private function showImageAngel(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < 7)
            {
                
                this.equipImageFactory[_loc_2].setInfo(null);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < 12)
            {
                
                this.equipImageWing[_loc_2].setInfo(null);
                this["wingImg" + (_loc_2 + 1)].txt.text = "";
                this["wingImg" + (_loc_2 + 1)].gotoAndStop(1);
                this["wingImg" + (_loc_2 + 1)].mc_mask.visible = false;
                this["wingImg" + (_loc_2 + 1)].removeEventListener(MouseEvent.CLICK, this.openChooseEquip);
                StringTip.dispose(this["wingImg" + (_loc_2 + 1)]);
                _loc_2++;
            }
            this.cur_use_not_sign_item_id = this.cur_Cfg.use_not_sign_item_id;
            this.saveEquipID = new long(0, 0);
            var _loc_3:* = "";
            this.count = 0;
            switch(param1.compose_id)
            {
                case 25:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11978");
                    break;
                }
                case 26:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11979");
                    break;
                }
                case 27:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11980");
                    break;
                }
                case 28:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11981");
                    break;
                }
                case 29:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11982");
                    break;
                }
                case 30:
                {
                    _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11983");
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("12379");
            if (param1.use_item)
            {
                _loc_7 = [];
                _loc_8 = [];
                _loc_9 = param1.use_item.split(";");
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    _loc_11 = _loc_9[_loc_10].split(",");
                    _loc_12 = BackpackObj.getInstance().getItemCount(_loc_11[0]);
                    _loc_13 = new PropInfo();
                    _loc_13.convByCfg(_loc_11[0]);
                    _loc_13.isMine = true;
                    _loc_7.push(_loc_13);
                    if (_loc_12 < _loc_11[1])
                    {
                        _loc_8[this.count] = 0;
                    }
                    else
                    {
                        _loc_8[this.count] = 1;
                    }
                    var _loc_15:* = this;
                    var _loc_16:* = this.count + 1;
                    _loc_15.count = _loc_16;
                    this["wingImg" + this.count].txt.text = _loc_12 + "/" + _loc_11[1];
                    this["wingImg" + this.count].gotoAndStop(1);
                    _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11984"), [_loc_13.q_name + _loc_11[1]]) + "");
                    _loc_10++;
                }
                _loc_10 = 0;
                while (_loc_10 < _loc_7.length)
                {
                    
                    this.equipImageWing[_loc_10].setInfo(_loc_7[_loc_10], false, "", 40, 40);
                    _loc_10++;
                }
                _loc_10 = 0;
                while (_loc_10 < _loc_8.length)
                {
                    
                    if (_loc_8[_loc_10] != null && _loc_8[_loc_10] == 1 || _loc_8[_loc_10] == null)
                    {
                        this["wingImg" + (_loc_10 + 1)].mc_mask.visible = false;
                    }
                    else
                    {
                        this["wingImg" + (_loc_10 + 1)].mc_mask.visible = true;
                    }
                    _loc_10++;
                }
            }
            var _loc_5:* = (param1.use_not_sign_item_id as String).split("_");
            var _loc_6:* = this.count + _loc_5.length;
            while (this.count < _loc_6)
            {
                
                _loc_14 = this.count + 1;
                this["wingImg" + _loc_14].gotoAndStop(3);
                _loc_4 = "<font color=\'#ffc000\'>" + LanguageCfgObj.getInstance().getByIndex("11985") + "\n</font>";
                StringTip.create(this["wingImg" + (this.count + 1)], _loc_4);
                this["wingImg" + _loc_14].type = EquipForgeData.TYPE_ANGEL;
                this["wingImg" + _loc_14].addEventListener(MouseEvent.CLICK, this.openChooseEquip);
                this["wingImg" + _loc_14].visible = true;
                var _loc_15:* = this;
                var _loc_16:* = this.count + 1;
                _loc_15.count = _loc_16;
            }
            while (this.count < 12)
            {
                
                this["wingImg" + (this.count + 1)].visible = false;
                var _loc_15:* = this;
                var _loc_16:* = this.count + 1;
                _loc_15.count = _loc_16;
            }
            this.txt_wingMataril.htmlText = _loc_3;
            return;
        }// end function

        private function showImageWing(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 7)
            {
                
                this.equipImageFactory[_loc_2].setInfo(null);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < 12)
            {
                
                this.equipImageWing[_loc_2].setInfo(null);
                this["wingImg" + (_loc_2 + 1)].txt.text = "";
                this["wingImg" + (_loc_2 + 1)].gotoAndStop(1);
                this["wingImg" + (_loc_2 + 1)].mc_mask.visible = false;
                this["wingImg" + (_loc_2 + 1)].removeEventListener(MouseEvent.CLICK, this.openChooseEquip);
                this["wingImg" + (_loc_2 + 1)].visible = true;
                StringTip.dispose(this["wingImg" + (_loc_2 + 1)]);
                _loc_2++;
            }
            this.cur_use_not_sign_item = "";
            this.saveEquipID = new long(0, 0);
            var _loc_3:* = "";
            this.count = 0;
            if (param1.use_item)
            {
                _loc_4 = [];
                _loc_5 = [];
                _loc_6 = param1.use_item.split(";");
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_8 = _loc_6[_loc_7].split(",");
                    _loc_9 = BackpackObj.getInstance().getItemCount(_loc_8[0]);
                    _loc_10 = new PropInfo();
                    _loc_10.convByCfg(_loc_8[0]);
                    _loc_10.isMine = true;
                    _loc_4.push(_loc_10);
                    if (_loc_9 < _loc_8[1])
                    {
                        _loc_5[this.count] = 0;
                    }
                    else
                    {
                        _loc_5[this.count] = 1;
                    }
                    var _loc_17:* = this;
                    var _loc_18:* = this.count + 1;
                    _loc_17.count = _loc_18;
                    this["wingImg" + this.count].txt.text = _loc_9 + "/" + _loc_8[1];
                    this["wingImg" + this.count].gotoAndStop(0);
                    _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11984"), [_loc_10.q_name + _loc_8[1]]) + "\n");
                    _loc_7++;
                }
                _loc_7 = 0;
                while (_loc_7 < _loc_4.length)
                {
                    
                    this.equipImageWing[_loc_7].setInfo(_loc_4[_loc_7], false, "", 40, 40);
                    _loc_7++;
                }
                _loc_7 = 0;
                while (_loc_7 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_7] != null && _loc_5[_loc_7] == 1 || _loc_5[_loc_7] == null)
                    {
                        this["wingImg" + (_loc_7 + 1)].mc_mask.visible = false;
                    }
                    else
                    {
                        this["wingImg" + (_loc_7 + 1)].mc_mask.visible = true;
                    }
                    _loc_7++;
                }
            }
            if (param1.use_not_sign_item)
            {
                this.cur_use_not_sign_item = param1.use_not_sign_item;
                this.cur_use_not_sign_item_id = param1.use_not_sign_item_id;
                _loc_11 = this.cur_use_not_sign_item.split(",");
                _loc_12 = "";
                if (int(_loc_11[3]) > 0)
                {
                    _loc_12 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11986"), [_loc_11[3]]);
                }
                var _loc_17:* = this;
                var _loc_18:* = this.count + 1;
                _loc_17.count = _loc_18;
                if (param1.compose_id == 16)
                {
                    this["wingImg" + this.count].gotoAndStop(3);
                    _loc_13 = "<font color=\'#ffc000\'>" + LanguageCfgObj.getInstance().getByIndex("11987") + "\n</font><font color=\'#ffffff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11988"), [_loc_11[2] + _loc_12]) + "</font>";
                    StringTip.create(this["wingImg" + this.count], _loc_13);
                    _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11991"), [_loc_11[2] + _loc_12]) + "\n");
                }
                else if (param1.compose_id == 17)
                {
                    this["wingImg" + this.count].gotoAndStop(2);
                    _loc_13 = "<font color=\'#ffc000\'>" + LanguageCfgObj.getInstance().getByIndex("11987") + "\n</font><font color=\'#ffffff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11989"), [_loc_11[2] + _loc_12]) + "\n<font color=\'#a5a5a5\'>" + LanguageCfgObj.getInstance().getByIndex("11990") + "</font></font>";
                    StringTip.create(this["wingImg" + this.count], _loc_13);
                    _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11992"), [_loc_11[2] + _loc_12]) + "\n");
                }
                else if (param1.compose_id == 18)
                {
                    this["wingImg" + this.count].gotoAndStop(5);
                    _loc_13 = LanguageCfgObj.getInstance().getByIndex("10613");
                    StringTip.create(this["wingImg" + this.count], _loc_13);
                    if (int(_loc_11[2]))
                    {
                        _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11993"), [_loc_11[2] + _loc_12]) + "\n");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("11994") + "\n");
                    }
                }
                else if (param1.compose_id == 22)
                {
                    this["wingImg" + this.count].gotoAndStop(5);
                    _loc_13 = LanguageCfgObj.getInstance().getByIndex("10614");
                    StringTip.create(this["wingImg" + this.count], _loc_13);
                    if (int(_loc_11[2]))
                    {
                        _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11995"), [_loc_11[2] + _loc_12]) + "\n");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("11996") + "\n");
                    }
                }
                this["wingImg" + this.count].type = 0;
                this["wingImg" + this.count].addEventListener(MouseEvent.CLICK, this.openChooseEquip);
            }
            if (param1.Q_Nonfinite_item)
            {
                this.cur_Q_Nonfinite_item = param1.Q_Nonfinite_item;
                _loc_11 = this.cur_Q_Nonfinite_item.split(",");
                _loc_12 = "";
                if (int(_loc_11[3]) > 0)
                {
                    _loc_12 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11986"), [_loc_11[3]]);
                }
                _loc_14 = param1.Q_Nonfinite_num > 8 ? (8) : (param1.Q_Nonfinite_num);
                _loc_15 = 0;
                while (_loc_15 < _loc_14)
                {
                    
                    this["wingImg" + (this.count + _loc_15 + 1)].gotoAndStop(4);
                    if (_loc_11[1] == "1")
                    {
                        _loc_16 = LanguageCfgObj.getInstance().getByIndex("10615");
                    }
                    else
                    {
                        _loc_16 = "";
                    }
                    _loc_13 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11997"), [_loc_16, _loc_11[2] + _loc_12]);
                    StringTip.create(this["wingImg" + (this.count + _loc_15 + 1)], _loc_13);
                    this["wingImg" + (this.count + _loc_15 + 1)].type = 1;
                    this["wingImg" + (this.count + _loc_15 + 1)].addEventListener(MouseEvent.CLICK, this.openChooseEquip);
                    _loc_15++;
                }
                if (_loc_11[2])
                {
                    _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11998"), [_loc_16, _loc_11[2] + _loc_12]);
                }
            }
            this.txt_wingMataril.text = _loc_3;
            return;
        }// end function

        public function showSelectEquip(param1) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.cur_selectIndex > 0)
            {
                this.equipImageWing[(this.cur_selectIndex - 1)].setInfo(param1, false, "", 40, 40);
                StringTip.dispose(this["wingImg" + this.cur_selectIndex]);
                this["wingImg" + this.cur_selectIndex].gotoAndStop(1);
                _loc_2 = EquipForgeData.saveEquipIdAdd;
                _loc_2[this.cur_selectIndex] = param1.itemId;
                if (this.cur_selectIndex == this.count)
                {
                    this.saveEquipID = param1.itemId;
                    if (param1.isbind)
                    {
                        this.hasBind = true;
                    }
                }
                if (this.curPage != EquipForgeData.TYPE_ANGEL)
                {
                    _loc_3 = 0;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_2.length)
                    {
                        
                        if (_loc_2[_loc_4])
                        {
                            _loc_6 = BackpackObj.getInstance().getItemById(_loc_2[_loc_4]) as EquipmentInfo;
                            if (!_loc_6)
                            {
                                _loc_6 = EquipsObj.getInstance().getEquipById(_loc_2[_loc_4]) as EquipmentInfo;
                            }
                            if (_loc_6)
                            {
                                _loc_3 = _loc_3 + EquipComposeAppendCfgObj.getInstance().getSucessRate(this.curCompose_id, _loc_6);
                            }
                        }
                        _loc_4++;
                    }
                    _loc_5 = int(this.cur_Cfg.success_percent) + _loc_3 > int(this.cur_Cfg.success_percent_max) ? (int(this.cur_Cfg.success_percent_max)) : (int(this.cur_Cfg.success_percent) + _loc_3);
                    this.txt_success_percent.text = _loc_5 / 100 + "%";
                }
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                if (!this._selectItemName)
                {
                    this.btn1.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                }
            }
            if (this._needAutoClick)
            {
                TweenLite.delayedCall(15, this.delayCompose);
            }
            return;
        }// end function

        private function delayCompose() : void
        {
            if (this.btn_Compose)
            {
                this.btn_Compose.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                this._needAutoClick = false;
            }
            return;
        }// end function

        private function clear() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            while (_loc_1 < 7)
            {
                
                if (this.equipImageFactory[_loc_1])
                {
                    this.equipImageFactory[_loc_1].setInfo(null);
                }
                _loc_1++;
            }
            _loc_2 = 0;
            while (_loc_2 < 12)
            {
                
                if (this.equipImageWing[_loc_2])
                {
                    this.equipImageWing[_loc_2].setInfo(null);
                }
                if (this["wingImg" + (_loc_2 + 1)])
                {
                    this["wingImg" + (_loc_2 + 1)].txt.text = "";
                    this["wingImg" + (_loc_2 + 1)].mc_mask.visible = false;
                    this["wingImg" + (_loc_2 + 1)].gotoAndStop(1);
                    this["wingImg" + (_loc_2 + 1)].removeEventListener(MouseEvent.CLICK, this.openChooseEquip);
                    StringTip.dispose(this["wingImg" + (_loc_2 + 1)]);
                    this["wingImg" + (_loc_2 + 1)].visible = true;
                }
                _loc_2++;
            }
            this.saveEquipID = new long(0, 0);
            this.curCompose_id = 0;
            if (this.hasInit)
            {
                this.txt_money_need.text = "";
                this.txt_diamond_need.text = "";
                this.txt_success_percent.text = "";
                this.check_btn.selected = false;
                this.img1.mc_mask.visible = false;
                this.img2.mc_mask.visible = false;
                this.img3.mc_mask.visible = false;
                this.img1.txt.text = "";
                this.img2.txt.text = "";
                this.img3.txt.text = "";
                this.btn_equip.gotoAndStop(4);
                this.mc_warning.visible = false;
                this.txt_warning.visible = false;
            }
            if (this.lastClickItem)
            {
                this.lastClickItem.selected = false;
            }
            this.curNeed = false;
            _loc_2 = 0;
            while (this.tree && _loc_2 < this.tree.length)
            {
                
                if (_loc_2 == 0)
                {
                    this.tree.setTreeItemUnfoldByIndex(_loc_2);
                }
                else
                {
                    this.tree.setTreeItemFoldByIndex(_loc_2);
                }
                _loc_2++;
            }
            if (this.btn_equip)
            {
                this.btn_equip.removeEventListener(MouseEvent.CLICK, this.openChooseEquip);
                StringTip.dispose(this.btn_equip);
            }
            this.cur_selectIndex = 0;
            EquipForgeData.saveEquipIdAdd = [];
            if (this.txt_wingMataril)
            {
                this.txt_wingMataril.text = "";
            }
            this.hasBind = false;
            return;
        }// end function

        private function showResultImage(param1:Object) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = 3;
            while (_loc_2 <= 5)
            {
                
                this.equipImageFactory[_loc_2].setInfo(null);
                _loc_2++;
            }
            var _loc_3:* = param1.other_result_items_client.split(";");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = PropUtil.createItemByCfg(_loc_3[_loc_4]);
                this.equipImageFactory[3 + _loc_4].setInfo(_loc_5, true, "", 56, 56);
                _loc_4++;
            }
            if (_loc_3.length > 1)
            {
                this.mc_warning.visible = true;
                this.txt_warning.visible = true;
                this.txt_warning.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11999"), [_loc_3.length]);
            }
            else
            {
                this.mc_warning.visible = false;
                this.txt_warning.visible = false;
            }
            return;
        }// end function

        private function openChooseEquip(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            this.cur_selectIndex = int(event.currentTarget.name.slice(7));
            var _loc_2:* = -1;
            if (this.cur_Cfg)
            {
                _loc_3 = this.cur_Cfg.use_item.split(";");
                _loc_2 = this.cur_selectIndex - _loc_3.length - 1;
            }
            EquipComposeControl.getInstance().openEquipComposeEquipSelectBox(event.currentTarget.type, _loc_2);
            return;
        }// end function

        private function filterEquip() : void
        {
            EquipComposeControl.getInstance().composeEquipSelectBox.cur_Q_Nonfinite_item = this.cur_Q_Nonfinite_item;
            EquipComposeControl.getInstance().composeEquipSelectBox.cur_use_not_sign_item_id = this.cur_use_not_sign_item_id;
            EquipComposeControl.getInstance().composeEquipSelectBox.cur_use_not_sign_item = this.cur_use_not_sign_item;
            this._vec = EquipComposeControl.getInstance().composeEquipSelectBox.vec;
            if (this._vec && this._vec.length > 0)
            {
                this.showSelectEquip(this._vec[0]);
            }
            return;
        }// end function

        private function playerEffect() : void
        {
            if (this._composeEffect == null)
            {
                this._composeEffect = new VMCView();
                this._composeEffect.loadRes("res/effect/composeEffect.png");
                this._composeEffect.auto = true;
            }
            if (this._composeEffect.parent == null)
            {
                this.tipsImg.addChild(this._composeEffect);
            }
            this._composeEffect.updatePose("90", false, false, true);
            this._composeEffect.move(85, 95);
            this._composeEffect.play();
            return;
        }// end function

        private function playerSuccessEffect(param1:int) : void
        {
            var _loc_2:* = null;
            if (_loc_2 == null)
            {
                _loc_2 = new VMCView();
                if (param1 == 1)
                {
                    _loc_2.loadRes("res/effect/successtips/composeSuccess.png");
                }
                else
                {
                    _loc_2.loadRes("res/effect/failtips/composeFail.png");
                }
                _loc_2.auto = true;
            }
            if (_loc_2.parent == null)
            {
                this.tipsImg.addChild(_loc_2);
            }
            _loc_2.updatePose("90", false, false, true);
            _loc_2.move(85, 95);
            _loc_2.play();
            return;
        }// end function

        private function playTips(param1:String) : void
        {
            if (!this.tipsImage)
            {
                this.tipsImage = new Image();
                this.tipsImage.smoothing = true;
            }
            if (!this.tipsImage.parent)
            {
                this.tipsImg.addChild(this.tipsImage);
            }
            this.tipsImage.load(param1, this.completeFunc);
            return;
        }// end function

        private function completeFunc(param1) : void
        {
            this.tipsImage.alpha = 1;
            this.tipsImage.scaleX = 0;
            this.tipsImage.scaleY = 0;
            this.tipsImage.y = 0;
            var _loc_2:* = this.tipsImage.width;
            var _loc_3:* = this.tipsImage.height;
            var _loc_4:* = new TimelineLite();
            _loc_4.append(new TweenLite(this.tipsImage, 0.4, {}));
            _loc_4.append(new TweenLite(this.tipsImage, 0.2, {scaleX:1.2, scaleY:1.2, x:(-_loc_2) * 0.1, y:(-_loc_3) * 0.1}));
            _loc_4.append(new TweenLite(this.tipsImage, 0.2, {scaleX:1, scaleY:1, x:0, y:0}));
            _loc_4.append(new TweenLite(this.tipsImage, 0.3, {}));
            _loc_4.append(new TweenLite(this.tipsImage, 0.5, {y:-10, alpha:0, onComplete:this.onComplete, onCompleteParams:[this.tipsImage]}));
            return;
        }// end function

        private function onComplete(param1:DisplayObject) : void
        {
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            this.tipsImage.dispose();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            var _loc_2:* = EquipComposeControl.getInstance().composeEquipSelectBox;
            if (_loc_2 && _loc_2.isOpen)
            {
                _loc_2.close();
            }
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.clear();
            this._selectItemName = "";
            this.guidePause(GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_3);
            this.guidePause(GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_3);
            TweenLite.killDelayedCallsTo(this.delayCompose);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this.btn_Compose, this, GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_2);
            GuideMultiControl.getInstance().registerGuide(this.closeBtn, this, GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_3);
            GuideMultiControl.getInstance().registerGuide(this.btn_Compose, this, GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_2);
            GuideMultiControl.getInstance().registerGuide(this.closeBtn, this, GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_3);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            switch(param1)
            {
                case GuideConfigObj.getInstance().COMPOSE_TICKET_GUIDE_ID_2:
                {
                    this.selectItemByItemName(LanguageCfgObj.getInstance().getByIndex("11689"));
                    break;
                }
                case GuideConfigObj.getInstance().COMPOSE_XS_DRESS_GUIDE_ID_2:
                {
                    this.selectItemByItemName(LanguageCfgObj.getInstance().getByIndex("12000"));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded && isOpen;
        }// end function

        public function get needAutoClick() : Boolean
        {
            return this._needAutoClick;
        }// end function

        public function set needAutoClick(param1:Boolean) : void
        {
            this._needAutoClick = param1;
            return;
        }// end function

    }
}
