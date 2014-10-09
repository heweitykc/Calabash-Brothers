package com.game.cloudbuy.view
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.*;
    import com.adobe.serialization.json.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.backpack.view.*;
    import com.game.cloudbuy.control.*;
    import com.game.cloudbuy.events.*;
    import com.game.cloudbuy.message.*;
    import com.game.cloudbuy.model.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CloudBuyBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var btn_lookLast:BaseButton;
        private var btn_backLast:BaseButton;
        private var txt_topic:TextField;
        private var mc_good:MovieClip;
        private var mc_good1:MovieClip;
        private var mc_good2:MovieClip;
        private var mc_good3:MovieClip;
        private var mc_good4:MovieClip;
        private var mc_List:MovieClip;
        private var _list:List;
        private var btn_buy:BaseButton;
        private var btn_nobuy:MovieClip;
        private var btn_getAward:BaseButton;
        private var btn_help:BaseButton;
        private var txt_biggood:TextField;
        private var txt_des:TextField;
        private var txt1:TextField;
        private var txt2:TextField;
        private var mc_rule:MovieClip;
        private var mc_addOne:MovieClip;
        private var mc_tips:MovieClip;
        private var mc_top:MovieClip;
        private var mc_animation:MovieClip;
        private var mc_luck:MovieClip;
        private var mc_num:MovieClip;
        private var imgNumber1:ImgNumber;
        private var imgNumber2:ImgNumber;
        private var imgNumber3:ImgNumber;
        private var mc_nonNumBuy:MovieClip;
        private var _type:int = 1;
        private var myleftnum:int = 0;
        private var josnObj:Object;
        private var imageArray:Array;
        private var _largeImage:IconItem;
        private var count:int = 0;

        public function CloudBuyBox()
        {
            this.imageArray = [];
            _peaceBox = ["*"];
            loadDisplay("res/cloudbuy.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("cloudBuyBox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            this.btn_lookLast = new BaseButton(getDisplayChildByName("btn_lookLast"));
            this.btn_backLast = new BaseButton(getDisplayChildByName("btn_backLast"));
            this.btn_backLast.visible = false;
            this.txt_topic = getDisplayChildByName("txt_topic");
            this.mc_good = getDisplayChildByName("mc_good");
            this.mc_good1 = getDisplayChildByName("mc_good1");
            this.mc_good2 = getDisplayChildByName("mc_good2");
            this.mc_good3 = getDisplayChildByName("mc_good3");
            this.mc_good4 = getDisplayChildByName("mc_good4");
            this.mc_List = getDisplayChildByName("mc_List");
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                _loc_2 = new IconItem("");
                _loc_2.setWH(40, 40);
                _loc_2.setImageSize(40, 40);
                _loc_2.x = 3;
                _loc_2.y = 3;
                this["mc_good" + (_loc_1 + 1)].addChild(_loc_2);
                this.imageArray.push(_loc_2);
                _loc_1++;
            }
            this._largeImage = new IconItem("");
            this._largeImage.setWH(58, 58);
            this._largeImage.setImageSize(58, 58);
            this.mc_good.addChild(this._largeImage);
            this.btn_buy = new BaseButton(getDisplayChildByName("btn_buy"));
            this.btn_nobuy = getDisplayChildByName("btn_nobuy");
            this.btn_getAward = new BaseButton(getDisplayChildByName("btn_getAward"));
            this.btn_help = new BaseButton(getDisplayChildByName("btn_help"));
            this.txt_biggood = getDisplayChildByName("txt_biggood");
            this.txt_des = getDisplayChildByName("txt_des");
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.mc_rule = getDisplayChildByName("mc_rule");
            this.mc_rule.visible = false;
            this.mc_addOne = getDisplayChildByName("mc_addOne");
            this.mc_addOne.visible = false;
            this.mc_tips = getDisplayChildByName("mc_tips");
            this.mc_tips.visible = false;
            this.mc_top = getDisplayChildByName("mc_top");
            this.mc_top.mouseEnabled = false;
            this.mc_animation = getDisplayChildByName("mc_animation");
            this.mc_luck = getDisplayChildByName("mc_luck");
            this.mc_num = getDisplayChildByName("mc_num");
            this.imgNumber1 = new ImgNumber();
            this.imgNumber2 = new ImgNumber();
            this.imgNumber3 = new ImgNumber();
            this.mc_num.num1.addChild(this.imgNumber1);
            this.mc_num.num2.addChild(this.imgNumber2);
            this.mc_num.num3.addChild(this.imgNumber3);
            this.mc_nonNumBuy = getDisplayChildByName("mc_nonNumBuy");
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            setWH(662, 515);
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_lookLast.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_backLast.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_buy.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_buy.addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.btn_buy.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.btn_getAward.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_help.addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.btn_help.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.txt1.addEventListener(TextEvent.LINK, this.__clickText);
            this.txt2.addEventListener(TextEvent.LINK, this.__clickText);
            this.mc_animation.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            CloudBuyData.getInstance().addEvtListener(CloudBuyEvent.CLOUD_BUY_INFO_CHANGE, this.update);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn_buy:
                {
                    this.mc_tips.visible = true;
                    break;
                }
                case this.btn_help:
                {
                    this.mc_rule.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn_buy:
                {
                    this.mc_tips.visible = false;
                    break;
                }
                case this.btn_help:
                {
                    this.mc_rule.visible = false;
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
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            switch(event.target)
            {
                case this.btn_lookLast:
                {
                    this.mc_animation.play();
                    this._type = 2;
                    break;
                }
                case this.btn_backLast:
                {
                    this.mc_animation.play();
                    this._type = 1;
                    break;
                }
                case this.btn_buy:
                {
                    _loc_2 = ToolKit.getServerDate();
                    if (_loc_2.hours >= 18)
                    {
                        CloudBuyControl.getInstance().reqCloudBuy(1);
                    }
                    else
                    {
                        _loc_3 = CloudBuyData.getInstance().cloudBuyID;
                        _loc_4 = CloudBuyCfgObj.getInstance().getCloudBuyInfoById(_loc_3);
                        if (this.myleftnum > 0)
                        {
                            if (UserObj.getInstance().playerInfo.gold < _loc_4.q_price)
                            {
                                MapControl.getInstance().showRechargeD();
                            }
                            else
                            {
                                CloudBuyControl.getInstance().reqCloudBuy(1);
                            }
                        }
                        else
                        {
                            _loc_5 = UserObj.getInstance().playerInfo.vipid;
                            _loc_6 = VipCfgObj.getInstance().getVipInfo(_loc_5).q_cloud_buy_rate / 10000;
                            _loc_7 = int(_loc_4.q_people_num) * _loc_6;
                            if (_loc_7 < 1)
                            {
                                _loc_7 = 1;
                            }
                            _loc_8 = VipCfgObj.getInstance().getVipInfo(4).q_cloud_buy_rate / 10000;
                            _loc_9 = int(_loc_4.q_people_num) * _loc_8;
                            if (_loc_9 < 1)
                            {
                                _loc_9 = 1;
                            }
                            _loc_10 = _loc_9 - _loc_7;
                            if (_loc_10 > 0)
                            {
                                _loc_11 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12374"), [_loc_5, _loc_7, _loc_10]);
                            }
                            else
                            {
                                _loc_11 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12375"), [_loc_5, _loc_7]);
                            }
                            Global.popManager.addedToMouseCue(_loc_11);
                        }
                    }
                    break;
                }
                case this.btn_getAward:
                {
                    CloudBuyControl.getInstance().reqCloudBuyReward();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = event.target as MovieClip;
            if (_loc_2.currentFrame == 55)
            {
                this.updateUI(this._type);
                this.update();
            }
            if (_loc_2.currentFrame == _loc_2.totalFrames)
            {
                _loc_2.gotoAndStop(1);
            }
            return;
        }// end function

        public function playEffect() : void
        {
            this.mc_addOne.visible = true;
            this.mc_addOne.play();
            return;
        }// end function

        private function updateUI(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    this.btn_lookLast.visible = true;
                    this.btn_backLast.visible = false;
                    this.mc_num.visible = true;
                    this.mc_nonNumBuy.visible = true;
                    break;
                }
                case 2:
                {
                    this.btn_lookLast.visible = false;
                    this.btn_backLast.visible = true;
                    this.mc_num.visible = false;
                    this.mc_nonNumBuy.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function update(event:CloudBuyEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            this.updatePublic();
            if (this._type == 1)
            {
                _loc_4 = CloudBuyData.getInstance().cloudBuyID;
            }
            else
            {
                _loc_4 = CloudBuyData.getInstance().lastCloudBuyID;
            }
            _loc_2 = CloudBuyCfgObj.getInstance().getCloudBuyInfoById(_loc_4);
            _loc_3 = CloudBuyData.getInstance().msg;
            if (!_loc_3)
            {
                return;
            }
            switch(this._type)
            {
                case 1:
                {
                    this.mc_luck.gotoAndStop(2);
                    this.txt_topic.text = _loc_2.q_topic;
                    this.txt_des.text = LanguageCfgObj.getInstance().getByIndex("12372");
                    this.mc_tips.txt_price.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12373"), [_loc_2.q_price]);
                    _loc_5 = _loc_2.q_item_id;
                    _loc_6 = _loc_5.split(";");
                    _loc_15 = 0;
                    while (_loc_15 < 4)
                    {
                        
                        if (_loc_15 < _loc_6.length)
                        {
                            _loc_16 = _loc_6[_loc_15].split("_");
                            _loc_17 = PropUtil.createItemByCfg(_loc_16[0]);
                            _loc_17.intensify = _loc_16[1];
                            _loc_17.addAttributLevel = _loc_16[2];
                            _loc_17.num = _loc_16[3];
                            this.imageArray[_loc_15].setInfo(_loc_17);
                            this.imageArray[_loc_15].count = _loc_16[3];
                        }
                        else
                        {
                            this.imageArray[_loc_15].setInfo(null);
                        }
                        _loc_15++;
                    }
                    _loc_7 = _loc_3.end.toNumber() - ToolKit.getServerTime();
                    _loc_7 = _loc_7 / 1000;
                    if (_loc_7 < 0)
                    {
                        _loc_7 = 0;
                    }
                    Ticker.killTimer(this.updateTime);
                    this.count = _loc_7;
                    if (this.count >= 1)
                    {
                        Ticker.registerTimer(1, this.updateTime, null, this.count);
                        MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_CLOUD_BUY, true);
                    }
                    else
                    {
                        MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_CLOUD_BUY, false);
                    }
                    _loc_8 = _loc_3.count;
                    _loc_9 = UserObj.getInstance().playerInfo.vipid;
                    _loc_10 = VipCfgObj.getInstance().getVipInfo(_loc_9).q_cloud_buy_rate / 10000;
                    _loc_11 = int(_loc_2.q_people_num) * _loc_10;
                    if (_loc_11 < 1)
                    {
                        _loc_11 = 1;
                    }
                    _loc_12 = int(_loc_2.q_people_num) - _loc_8;
                    this.myleftnum = _loc_11 - _loc_3.mycount;
                    this.myleftnum = this.myleftnum > _loc_12 ? (_loc_12) : (this.myleftnum);
                    this.imgNumber1.reset();
                    this.imgNumber2.reset();
                    this.imgNumber3.reset();
                    this.imgNumber1.setNumber("" + _loc_8, 15);
                    this.imgNumber2.setNumber("" + _loc_12, 16);
                    this.imgNumber3.setNumber("" + _loc_3.mycount, 17);
                    this.mc_num.mc_picnum.x = this.mc_num.num3.x + this.mc_num.num3.width + 2;
                    if (_loc_7 <= 0)
                    {
                        this.btn_buy.visible = false;
                        this.btn_nobuy.visible = true;
                        this.btn_nobuy.gotoAndStop(1);
                        this.btn_getAward.visible = false;
                    }
                    else if (_loc_12 <= 0)
                    {
                        this.btn_buy.visible = false;
                        this.btn_nobuy.visible = true;
                        this.btn_nobuy.gotoAndStop(2);
                        this.btn_getAward.visible = false;
                    }
                    else
                    {
                        this.btn_buy.visible = true;
                        this.btn_nobuy.visible = false;
                        this.btn_getAward.visible = false;
                    }
                    break;
                }
                case 2:
                {
                    this.mc_luck.gotoAndStop(1);
                    this.txt_topic.text = _loc_3.name;
                    this.txt_des.text = LanguageCfgObj.getInstance().getByIndex("12376");
                    _loc_13 = _loc_3.itemInfoList;
                    _loc_15 = 0;
                    while (_loc_15 < 4)
                    {
                        
                        if (_loc_15 < _loc_13.length)
                        {
                            _loc_17 = PropUtil.createItemByCfg(_loc_13[_loc_15].itemModelId);
                            _loc_17.num = _loc_13[_loc_15].num;
                            this.imageArray[_loc_15].setInfo(_loc_17);
                            this.imageArray[_loc_15].count = _loc_13[_loc_15].num;
                        }
                        else
                        {
                            this.imageArray[_loc_15].setInfo(null);
                        }
                        _loc_15++;
                    }
                    _loc_14 = CloudBuyData.getInstance().cloudBuyState;
                    if (_loc_14 == 0)
                    {
                        this.btn_buy.visible = false;
                        this.btn_nobuy.visible = false;
                        this.btn_getAward.visible = true;
                        this.btn_getAward.enabled = false;
                        this.btn_getAward.filters = [FrameworkGlobal.colorMat];
                    }
                    else if (_loc_14 == 1)
                    {
                        this.btn_buy.visible = false;
                        this.btn_nobuy.visible = false;
                        this.btn_getAward.visible = true;
                        this.btn_getAward.enabled = true;
                        this.btn_getAward.filters = null;
                    }
                    else if (_loc_14 == 2)
                    {
                        this.btn_buy.visible = false;
                        this.btn_nobuy.visible = false;
                        this.btn_getAward.visible = true;
                        this.btn_getAward.enabled = false;
                        this.btn_getAward.filters = [FrameworkGlobal.colorMat];
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

        private function updateTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.count - 1;
            _loc_1.count = _loc_2;
            if (this.count <= 0)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_CLOUD_BUY, false);
            }
            return;
        }// end function

        private function updatePublic() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (this._type == 1)
            {
                _loc_3 = CloudBuyData.getInstance().cloudBuyID;
            }
            else
            {
                _loc_3 = CloudBuyData.getInstance().lastCloudBuyID;
            }
            var _loc_1:* = CloudBuyCfgObj.getInstance().getCloudBuyInfoById(_loc_3);
            var _loc_2:* = CloudBuyData.getInstance().msg;
            if (_loc_1)
            {
                this.txt_biggood.text = LanguageCfgObj.getInstance().getByIndex("12377") + _loc_1.q_price_show;
                _loc_4 = UserObj.getInstance().playerInfo.jobkind;
                _loc_5 = PropUtil.getItemInfos(_loc_1["q_reward_id_show" + _loc_4]);
                _loc_6 = 0;
                while (_loc_6 < 1)
                {
                    
                    if (_loc_5[_loc_6])
                    {
                        this._largeImage.setInfo(_loc_5[_loc_6]);
                    }
                    _loc_6++;
                }
            }
            else
            {
                this.txt_biggood.text = "";
                this._largeImage.setInfo(null);
            }
            this.changeTxt();
            this.setAnimmation();
            if (_loc_2)
            {
                _loc_7 = _loc_2.cloudBuyEventInfoList;
                _loc_6 = 0;
                while (_loc_7 && _loc_6 < 1)
                {
                    
                    _loc_6++;
                }
            }
            return;
        }// end function

        private function setAnimmation() : void
        {
            Ticker.killTimer(this.changeTxt);
            Ticker.registerTimer(5, this.changeTxt);
            return;
        }// end function

        private function changeTxt() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.txt1.text = "";
            this.txt2.text = "";
            var _loc_1:* = CloudBuyData.getInstance().msg;
            if (_loc_1)
            {
                _loc_2 = _loc_1.cloudBuyEventInfoList;
                _loc_3 = 0;
                while (_loc_2 && _loc_3 < 1 && _loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = _loc_2[_loc_3].message;
                    this.josnObj = JSON.decode(_loc_4);
                    _loc_5 = "<font color=\'#13a400\'><a href=\'event:click1\'><u>" + this.josnObj.ps[0].name + "</u></a></font><font color=\'#8c774f\'>";
                    this.josnObj.t = (this.josnObj.t as String).replace("{@}", _loc_5);
                    this.txt1.htmlText = this.josnObj.t;
                    this.txt2.htmlText = this.josnObj.t;
                    this.txt1.alpha = 1;
                    this.txt1.y = 485;
                    TweenLite.to(this.txt1, 0.5, {y:this.txt1.y - 10, alpha:0});
                    this.txt2.alpha = 0;
                    this.txt2.y = 485 + 10;
                    TweenLite.to(this.txt2, 0.5, {y:this.txt2.y - 10, alpha:1});
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function __clickText(event:TextEvent) : void
        {
            var _loc_2:* = null;
            if (event.text == "click1")
            {
                _loc_2 = new RoleInfo();
                _loc_2.personId = long.parselong(this.josnObj.ps[0].pid);
                _loc_2.name = this.josnObj.ps[0].name;
                ItemPopMenu.instance.show(null, FrameworkGlobal.stage, 0, 0, ItemPopMenu.GUILD, _loc_2);
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
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
            CloudBuyControl.getInstance().reqOpenCloudBuyInfo();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
