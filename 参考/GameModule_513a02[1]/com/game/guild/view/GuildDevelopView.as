package com.game.guild.view
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.model.*;
    import com.game.guild.bean.*;
    import com.game.guild.control.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildDevelopView extends Component
    {
        private var check_btn:BaseButton;
        private var check_btn1:BaseButton;
        private var check_btn2:BaseButton;
        private var btn_submitItem:BaseButton;
        private var btn_changeLevel:BaseButton;
        private var btn_look:BaseButton;
        private var txt_money:TextField;
        private var txt_contribute:TextField;
        private var txt_contributionPoint:TextField;
        private var txt_subMoney:TextField;
        private var txt_subGoods:TextField;
        private var txt_contrbition1:TextField;
        private var txt_contrbition2:TextField;
        private var txt_addatt:TextField;
        private var txt_att1:TextField;
        private var txt_att2:TextField;
        private var txt_att3:TextField;
        private var img1:MovieClip;
        private var img2:MovieClip;
        private var img3:MovieClip;
        private var img4:MovieClip;
        private var img11:MovieClip;
        private var img21:MovieClip;
        private var img31:MovieClip;
        private var img41:MovieClip;
        private var _image1:IconItem;
        private var _image2:IconItem;
        private var _image3:IconItem;
        private var _image4:IconItem;
        private var txt_number1:TextField;
        private var txt_number2:TextField;
        private var txt_number3:TextField;
        private var txt_number4:TextField;
        private var mc_bannerLevel:MovieClip;
        private var mc_bannerLevel2:MovieClip;
        private var bannerImg:MovieClip;
        private var _bannerImg:VMCView;
        private var goodsIdArray:Array;
        private var curSelectGoods:int = -1;
        private var lastSelectItem:IconItem;
        private var curBannerIcon:int = 1;
        private var url:Array;
        private var imgArr:Array;

        public function GuildDevelopView()
        {
            this.goodsIdArray = [700037, 700038, 700039, 700040];
            this.url = ["", "ms107", "ms108", "ms109", "ms110", "ms111", "ms112", "ms113", "ms114", "ms115", "ms116", "ms117", "ms118"];
            this.imgArr = [];
            initComponentUI("guildDevelopPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.check_btn = new BaseButton(getDisplayChildByName("check_btn"), true);
            this.check_btn.selected = false;
            this.check_btn.setText(LanguageCfgObj.getInstance().getByIndex("10800"));
            this.check_btn1 = new BaseButton(getDisplayChildByName("check_btn1"), true);
            this.check_btn2 = new BaseButton(getDisplayChildByName("check_btn2"), true);
            this.btn_submitItem = new BaseButton(getDisplayChildByName("btn_submitItem"));
            this.btn_submitItem.setText(LanguageCfgObj.getInstance().getByIndex("10801"));
            this.btn_changeLevel = new BaseButton(getDisplayChildByName("btn_changeLevel"));
            this.btn_changeLevel.setText(LanguageCfgObj.getInstance().getByIndex("10802"));
            this.btn_look = new BaseButton(getDisplayChildByName("btn_look"));
            StringTip.create(this.btn_look, LanguageCfgObj.getInstance().getByIndex("10803"));
            this.txt_money = getDisplayChildByName("txt_money");
            this.txt_money.selectable = false;
            this.txt_contribute = getDisplayChildByName("txt_contribute");
            this.txt_contribute.selectable = false;
            this.txt_contributionPoint = getDisplayChildByName("txt_contributionPoint");
            this.txt_contributionPoint.selectable = false;
            this.txt_subMoney = getDisplayChildByName("txt_subMoney");
            this.txt_subGoods = getDisplayChildByName("txt_subGoods");
            this.txt_contrbition1 = getDisplayChildByName("txt_contrbition1");
            this.txt_contrbition2 = getDisplayChildByName("txt_contrbition2");
            this.txt_contrbition1.restrict = "0-9";
            this.txt_contrbition2.restrict = "0-9";
            this.txt_addatt = getDisplayChildByName("txt_addatt");
            this.txt_att1 = getDisplayChildByName("txt_att1");
            this.txt_att2 = getDisplayChildByName("txt_att2");
            this.txt_att3 = getDisplayChildByName("txt_att3");
            this.img1 = getDisplayChildByName("img1");
            this.img2 = getDisplayChildByName("img2");
            this.img3 = getDisplayChildByName("img3");
            this.img4 = getDisplayChildByName("img4");
            var _loc_1:* = 0;
            while (_loc_1 < this.goodsIdArray.length)
            {
                
                this["_image" + (_loc_1 + 1)] = new IconItem("");
                this["_image" + (_loc_1 + 1)].setWH(40, 40);
                this["_image" + (_loc_1 + 1)].setImageSize(40, 40);
                this["_image" + (_loc_1 + 1)].x = 3;
                this["_image" + (_loc_1 + 1)].y = 3;
                this["_image" + (_loc_1 + 1)].name = _loc_1;
                this["_image" + (_loc_1 + 1)].addEventListener(MouseEvent.CLICK, this.__selectGoods);
                this["img" + (_loc_1 + 1)].addChild(this["_image" + (_loc_1 + 1)]);
                _loc_2 = new PropInfo();
                _loc_2.convByCfg(this.goodsIdArray[_loc_1]);
                this["_image" + (_loc_1 + 1)].setInfo(_loc_2);
                ItemTips.create(this["img" + (_loc_1 + 1)], _loc_2, PropTips);
                _loc_1++;
            }
            this.img11 = getDisplayChildByName("img11");
            this.img21 = getDisplayChildByName("img21");
            this.img31 = getDisplayChildByName("img31");
            this.img41 = getDisplayChildByName("img41");
            this.txt_number1 = getDisplayChildByName("txt_number1");
            this.txt_number2 = getDisplayChildByName("txt_number2");
            this.txt_number3 = getDisplayChildByName("txt_number3");
            this.txt_number4 = getDisplayChildByName("txt_number4");
            this.txt_number1.mouseEnabled = false;
            this.txt_number2.mouseEnabled = false;
            this.txt_number3.mouseEnabled = false;
            this.txt_number4.mouseEnabled = false;
            this.mc_bannerLevel = getDisplayChildByName("mc_bannerLevel");
            this.mc_bannerLevel2 = getDisplayChildByName("mc_bannerLevel2");
            this.bannerImg = getDisplayChildByName("bannerImg");
            this.bannerImg.mouseEnabled = false;
            this.bannerImg.mouseChildren = false;
            this._bannerImg = new VMCView();
            this._bannerImg.smoothing = true;
            this._bannerImg.auto = true;
            this._bannerImg.updatePose("90", true, true);
            this._bannerImg.move(0, 85);
            this._bannerImg.scale = 0.9;
            this.bannerImg.addChild(this._bannerImg);
            _loc_1 = 0;
            while (_loc_1 < this.goodsIdArray.length)
            {
                
                _loc_3 = new IconItem("");
                _loc_3.setWH(40, 40);
                _loc_3.setImageSize(40, 40);
                _loc_3.x = 3;
                _loc_3.y = 3;
                ToolKit.clearMcChild(this["img" + (_loc_1 + 1) + "1"]);
                this["img" + (_loc_1 + 1) + "1"].addChild(_loc_3);
                this.imgArr.push(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.check_btn.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.check_btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_submitItem.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_changeLevel.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn_changeLevel.addEventListener(MouseEvent.MOUSE_OVER, this.__over, false, 0, true);
            this.btn_changeLevel.addEventListener(MouseEvent.MOUSE_OUT, this.__out, false, 0, true);
            this.txt_subMoney.addEventListener(Event.CHANGE, this.__textInputMoney, false, 0, true);
            this.txt_subGoods.addEventListener(Event.CHANGE, this.__textInputGoods, false, 0, true);
            this.txt_subMoney.addEventListener(MouseEvent.CLICK, this.__clickMoney, false, 0, true);
            this.txt_subGoods.addEventListener(MouseEvent.CLICK, this.__clickGoods, false, 0, true);
            GuildData.getInstance().addEvtListener(GuildEvent.GUILD_INFO_CHANGE, this.update);
            GuildData.getInstance().addEvtListener(GuildEvent.MY_MEMBER_INFO_CHANGE, this.update);
            return;
        }// end function

        private function __textInputMoney(event:Event) : void
        {
            var _loc_2:* = int(this.txt_subMoney.text);
            if (_loc_2 * 10000 > UserObj.getInstance().playerInfo.money)
            {
                _loc_2 = int(UserObj.getInstance().playerInfo.money / 10000);
            }
            this.txt_subMoney.text = "" + _loc_2;
            this.txt_contrbition1.text = "= " + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12069"), [int(_loc_2 / 50)]);
            return;
        }// end function

        private function __textInputGoods(event:Event) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = int(this.txt_subGoods.text);
            if (this.curSelectGoods > -1)
            {
                _loc_3 = BackpackObj.getInstance().getItemCount(this.goodsIdArray[this.curSelectGoods]);
                if (_loc_2 > _loc_3)
                {
                    _loc_2 = _loc_3;
                }
                this.txt_subGoods.text = "" + _loc_2;
                this.txt_contrbition2.text = "= " + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12069"), [_loc_2 * 10]);
            }
            else
            {
                this.txt_subGoods.text = "0";
                this.txt_contrbition2.text = LanguageCfgObj.getInstance().getByIndex("10804");
            }
            return;
        }// end function

        private function __clickMoney(event:MouseEvent) : void
        {
            this.check_btn1.selected = true;
            this.check_btn2.selected = false;
            this.reset2();
            return;
        }// end function

        private function __clickGoods(event:MouseEvent) : void
        {
            this.check_btn1.selected = false;
            this.check_btn2.selected = true;
            this.reset3();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.check_btn:
                {
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1)
                    {
                        GuildControl.getInstance().reqGuildAutoGuildArgeeAdd(UserObj.getInstance().playerInfo.guildId, this.check_btn.selected ? (1) : (0));
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10805"));
                        this.check_btn.selected = !this.check_btn.selected;
                    }
                    break;
                }
                case this.check_btn1:
                {
                    this.check_btn2.selected = !this.check_btn1.selected;
                    this.reset2();
                    break;
                }
                case this.check_btn2:
                {
                    this.check_btn1.selected = !this.check_btn2.selected;
                    this.reset2();
                    break;
                }
                case this.btn_submitItem:
                {
                    if (this.check_btn1.selected)
                    {
                        if (int(this.txt_subMoney.text) > 0)
                        {
                            GuildControl.getInstance().reqGuildSubmitItem(GuildData.getInstance().myMemberInfo.guildId, 5, int(this.txt_subMoney.text) * 10000);
                        }
                        else
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10806"));
                        }
                    }
                    else if (this.check_btn2.selected)
                    {
                        if (this.curSelectGoods != -1)
                        {
                            if (int(this.txt_subGoods.text) > 0)
                            {
                                GuildControl.getInstance().reqGuildSubmitItem(GuildData.getInstance().myMemberInfo.guildId, (this.curSelectGoods + 1), int(this.txt_subGoods.text));
                            }
                            else
                            {
                                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10807"));
                            }
                        }
                        else
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10808"));
                        }
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10809"));
                    }
                    break;
                }
                case this.btn_changeLevel:
                {
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel != 1 && GuildData.getInstance().myMemberInfo.guildPowerLevel != 2)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10810"));
                        return;
                    }
                    GuildControl.getInstance().openGuildBannerChangeLevelPanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = GuildData.getInstance().guildInfo;
            if (_loc_2)
            {
                _loc_3 = _loc_2.bannerLevel + 1;
                if (_loc_3 > 10)
                {
                    _loc_3 = 10;
                }
                _loc_4 = BannerCfgObj.getInstance().getGuildBannerinfoByLev(_loc_3);
                _loc_5 = _loc_4.q_attribute;
                _loc_5 = _loc_5.substring(2, _loc_5.length - 2);
                _loc_6 = _loc_5.split(",");
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    if (_loc_6[_loc_7])
                    {
                        this["txt_att" + (_loc_7 + 1)].text = _loc_6[_loc_7];
                    }
                    _loc_7++;
                }
                this.txt_addatt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12070"), [_loc_3]);
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = GuildData.getInstance().guildInfo;
            if (_loc_2)
            {
                _loc_3 = BannerCfgObj.getInstance().getGuildBannerinfoByLev(_loc_2.bannerLevel);
                _loc_4 = _loc_3.q_attribute;
                _loc_4 = _loc_4.substring(2, _loc_4.length - 2);
                _loc_5 = _loc_4.split(",");
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_6])
                    {
                        this["txt_att" + (_loc_6 + 1)].text = _loc_5[_loc_6];
                    }
                    _loc_6++;
                }
                this.txt_addatt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12070"), [_loc_2.bannerLevel]);
            }
            return;
        }// end function

        private function __selectGoods(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as IconItem;
            if (_loc_2)
            {
                this.curSelectGoods = int(_loc_2.name);
                if (this.lastSelectItem)
                {
                    this.lastSelectItem.setSelected = false;
                }
                _loc_2.setSelected = true;
                this.lastSelectItem = _loc_2;
                this.check_btn1.selected = false;
                this.check_btn2.selected = true;
                this.reset3();
            }
            return;
        }// end function

        public function update(event:Event = null) : void
        {
            if (event && !stage)
            {
                return;
            }
            if (!event)
            {
                this.reset1();
            }
            this.updateUI();
            this.updateMc();
            return;
        }// end function

        private function updateUI() : void
        {
            if (!GuildData.getInstance().guildInfo)
            {
                return;
            }
            this.check_btn.selected = GuildData.getInstance().guildInfo.autoGuildAgreeAdd > 0 ? (true) : (false);
            return;
        }// end function

        private function updateMc() : void
        {
            var _loc_9:* = null;
            if (!GuildData.getInstance().guildInfo)
            {
                return;
            }
            var _loc_1:* = GuildData.getInstance().guildInfo;
            var _loc_2:* = _loc_1.stockGold.toString();
            _loc_2 = _loc_2.slice(0, _loc_2.length - 4);
            var _loc_3:* = int(_loc_2 == "" ? ("0") : (_loc_2));
            this.txt_money.text = ToolKit.getMoneyString(_loc_3) + LanguageCfgObj.getInstance().getByIndex("10030");
            this.txt_contribute.text = "" + _loc_1.guildContribution;
            this.txt_contributionPoint.text = GuildData.getInstance().myMemberInfo.contributionPoint.toString();
            this.txt_number1.text = "" + BackpackObj.getInstance().getItemCount(this.goodsIdArray[0]);
            this.txt_number2.text = "" + BackpackObj.getInstance().getItemCount(this.goodsIdArray[1]);
            this.txt_number3.text = "" + BackpackObj.getInstance().getItemCount(this.goodsIdArray[2]);
            this.txt_number4.text = "" + BackpackObj.getInstance().getItemCount(this.goodsIdArray[3]);
            this.txt_addatt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12070"), [_loc_1.bannerLevel]);
            var _loc_4:* = BannerCfgObj.getInstance().getGuildBannerinfoByLev(_loc_1.bannerLevel);
            _loc_2 = _loc_4.q_attribute;
            _loc_2 = _loc_2.substring(2, _loc_2.length - 2);
            var _loc_5:* = _loc_2.split(",");
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6])
                {
                    this["txt_att" + (_loc_6 + 1)].text = _loc_5[_loc_6];
                }
                _loc_6++;
            }
            this.curBannerIcon = _loc_1.bannerIcon;
            this._bannerImg.loadRes("art/res/role/gen/" + this.url[this.curBannerIcon] + "/act01.png");
            var _loc_7:* = _loc_1.bannerLevel;
            if (_loc_1.bannerLevel >= 10)
            {
                this.mc_bannerLevel.gotoAndStop((int(_loc_7 / 10) + 1));
                this.mc_bannerLevel2.gotoAndStop(int(_loc_7 % 10));
                this.mc_bannerLevel.visible = true;
                this.mc_bannerLevel2.visible = true;
                this.btn_changeLevel.enabled = false;
            }
            else
            {
                this.mc_bannerLevel.gotoAndStop((_loc_7 + 1));
                this.btn_changeLevel.enabled = true;
                this.mc_bannerLevel.visible = true;
                this.mc_bannerLevel2.visible = false;
            }
            var _loc_8:* = ["dragon", "whiteTiger", "suzaku", "basaltic"];
            _loc_6 = 0;
            while (_loc_6 < this.goodsIdArray.length)
            {
                
                _loc_9 = new PropInfo();
                _loc_9.convByCfg(this.goodsIdArray[_loc_6]);
                this.imgArr[_loc_6].setInfo(_loc_9);
                _loc_9.num = _loc_1[_loc_8[_loc_6]];
                this.imgArr[_loc_6].setCount(_loc_1[_loc_8[_loc_6]], true);
                ItemTips.create(this.imgArr[_loc_6], _loc_9, PropTips);
                _loc_6++;
            }
            return;
        }// end function

        public function reset1() : void
        {
            this.txt_subGoods.text = "1";
            this.txt_subMoney.text = "50";
            this.txt_contrbition1.text = LanguageCfgObj.getInstance().getByIndex("10811");
            this.txt_contrbition2.text = LanguageCfgObj.getInstance().getByIndex("10811");
            this.check_btn1.selected = true;
            this.check_btn2.selected = false;
            this.curSelectGoods = -1;
            if (this.lastSelectItem)
            {
                this.lastSelectItem.setSelected = false;
            }
            return;
        }// end function

        public function reset2() : void
        {
            this.txt_subGoods.text = "1";
            this.txt_subMoney.text = "50";
            this.txt_contrbition1.text = LanguageCfgObj.getInstance().getByIndex("10811");
            this.txt_contrbition2.text = LanguageCfgObj.getInstance().getByIndex("10811");
            this.curSelectGoods = -1;
            if (this.lastSelectItem)
            {
                this.lastSelectItem.setSelected = false;
            }
            return;
        }// end function

        public function reset3() : void
        {
            this.txt_subGoods.text = "1";
            this.txt_subMoney.text = "50";
            this.txt_contrbition1.text = LanguageCfgObj.getInstance().getByIndex("10811");
            this.txt_contrbition2.text = LanguageCfgObj.getInstance().getByIndex("10811");
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
