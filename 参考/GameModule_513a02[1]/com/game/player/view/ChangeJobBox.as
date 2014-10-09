package com.game.player.view
{
    import avmplus.*;
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.effect.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.model.*;
    import com.game.challenge.event.*;
    import com.game.guide.control.*;
    import com.game.map.bean.*;
    import com.game.map.control.*;
    import com.game.operationpanel.view.*;
    import com.game.player.control.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.game.utils.*;
    import com.game.vip.control.*;
    import com.greensock.*;
    import com.greensock.data.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class ChangeJobBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn_compelete:BaseButton;
        private var bg:MovieClip;
        private var mc_jobAtt:MovieClip;
        private var job1:MovieClip;
        private var job2:MovieClip;
        private var job3:MovieClip;
        private var job4:MovieClip;
        private var mc_shoe:BaseButton;
        private var mc_one:MovieClip;
        private var mc_two:MovieClip;
        private var mc_master:MovieClip;
        private var mc_video:MovieClip;
        private var btn_onekey:BaseButton;
        private var mc_npc:MovieClip;
        private var mc_step:MovieClip;
        private var mc_shoeStep:BaseButton;
        private var mc_shoeNpc:BaseButton;
        private var mc_tips:MovieClip;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc_img1:MovieClip;
        private var mc_img2:MovieClip;
        private var imgBoss:MovieClip;
        private var img1:Image;
        private var img2:Image;
        private var effect:MovieClip;
        private var txt_value1:TextField;
        private var txt_value2:TextField;
        private var txt_value3:TextField;
        private var txt_condition1:TextField;
        private var txt_condition2:TextField;
        private var txt_condition3:TextField;
        private var txt_condition4:TextField;
        private var mc_masterjobAtt:MovieClip;
        private var txt_mastervalue1:TextField;
        private var txt_mastervalue2:TextField;
        private var txt_mastervalue3:TextField;
        private var masterjob1:MovieClip;
        private var masterjob2:MovieClip;
        private var txt_goto:TextField;
        private var mc_mastershoe:BaseButton;
        private var btn_info:BaseButton;
        private var txt_mastercondition1:TextField;
        private var txt_mastercondition2:TextField;
        private var mc_masterMC1:MovieClip;
        private var mc_masterMC2:MovieClip;
        private var mc_masterMC3:MovieClip;
        private var mc_masterArr:Array;
        private var mc_master1:MovieClip;
        private var mc_master2:MovieClip;
        private var mc_master3:MovieClip;
        private var mc_master4:MovieClip;
        private var mc_master5:MovieClip;
        private var mc_master6:MovieClip;
        private var mc_master7:MovieClip;
        private var mc_master8:MovieClip;
        private var mc_master9:MovieClip;
        private var mc_master10:MovieClip;
        private var mc_master11:MovieClip;
        private var mc_master12:MovieClip;
        private var mc_master13:MovieClip;
        private var mc_master14:MovieClip;
        private var mc_master15:MovieClip;
        private var mc_master16:MovieClip;
        private var mc_master17:MovieClip;
        private var mc_master18:MovieClip;
        private var mc_master19:MovieClip;
        private var mc_master20:MovieClip;
        private var masterStarID:int = 701025;
        private var expID:int = 701026;
        private var hasOpenTipsDay:Boolean = false;
        private var masterStarNum:int = 20;
        private var curMasterStar:int = 0;
        private var _type:int = 1;
        private var btnAry:Array;
        private var strArray1:Array;
        private var strArray2:Array;
        private var strArray3:Array;
        private var strArray4:Array;
        private var strArray5:Array;
        private var strArray6:Array;
        private var strArray7:Array;
        private var strArray8:Array;
        private var strArray9:Array;
        private var needLevel:Array;
        private var needLevel2:Array;
        private var goodID1:Array;
        private var goodID2:Array;
        private var goodID3:int = 600005;
        private var addValue11:Array;
        private var addValue12:Array;
        private var addValue13:Array;
        private var addValue21:Array;
        private var addValue22:Array;
        private var addValue23:Array;
        private var addValue31:Array;
        private var addValue32:Array;
        private var addValue33:Array;
        private var _changeEffect:VMCView;
        private var _weaponEffect:VMCView;
        private var _ballEffect:VMCView;
        private var good1:int = 0;
        private var good2:int = 0;
        private var skillItem1:ShortcutBox;
        private var skillItem2:ShortcutBox;
        private var skillItem3:ShortcutBox;
        private var skillItem4:ShortcutBox;
        private var skillItemArray:Array;
        private var skillItemSelectArray:Array;
        private var changeJobSkill1:ChangeJobSkill1;
        private var changeJobSkill2:ChangeJobSkill2;
        private var changeJobSkill3:ChangeJobSkill3;
        private var changeJobSkill4:ChangeJobSkill4;
        private var skillID1:Array;
        private var skillID2:Array;
        private var skillID3:Array;
        private var skillID4:Array;
        private var index:int = 0;
        private var effectFail:VMCView;
        private var effectFail2:VMCView;
        private var effect1:VMCView;
        private var effect2:VMCView;
        private var saveNum:int;
        private var effect31:Image;
        private var effect32:Image;
        private var effect33:Image;
        private var effect34:Image;
        private var effect4:VMCView;
        private var effect5:VMCView;

        public function ChangeJobBox()
        {
            this.mc_masterArr = [];
            this.btnAry = [];
            this.strArray1 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11736"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11738"), LanguageCfgObj.getInstance().getByIndex("11739")];
            this.strArray2 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11736"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11742"), LanguageCfgObj.getInstance().getByIndex("11739")];
            this.strArray3 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11736"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11745"), LanguageCfgObj.getInstance().getByIndex("11739")];
            this.strArray4 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11746"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11747"), LanguageCfgObj.getInstance().getByIndex("11748")];
            this.strArray5 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11746"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11747"), LanguageCfgObj.getInstance().getByIndex("11748")];
            this.strArray6 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11746"), LanguageCfgObj.getInstance().getByIndex("11737"), LanguageCfgObj.getInstance().getByIndex("11747"), LanguageCfgObj.getInstance().getByIndex("11748")];
            this.strArray7 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11749"), LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11750"), LanguageCfgObj.getInstance().getByIndex("11751")];
            this.strArray8 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11749"), LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11750"), LanguageCfgObj.getInstance().getByIndex("11751")];
            this.strArray9 = [LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11749"), LanguageCfgObj.getInstance().getByIndex("11735"), LanguageCfgObj.getInstance().getByIndex("11750"), LanguageCfgObj.getInstance().getByIndex("11751")];
            this.needLevel = [150, 150, 220, 220];
            this.needLevel2 = [290, 300, 310];
            this.goodID1 = [700120, 700121, 700122, 700123];
            this.goodID2 = [700124, 700125];
            this.addValue11 = [110, 40, 820];
            this.addValue12 = [130, 36, 660];
            this.addValue13 = [100, 50, 780];
            this.addValue21 = [220, 80, 1640];
            this.addValue22 = [260, 72, 1320];
            this.addValue23 = [200, 100, 1560];
            this.addValue31 = [70, 20, 3280, 140, 40, 6560, 230, 100, 9840];
            this.addValue32 = [80, 20, 2640, 160, 40, 5280, 280, 84, 7920];
            this.addValue33 = [60, 30, 3120, 120, 60, 6240, 220, 110, 9360];
            this.skillItemArray = [];
            this.skillItemSelectArray = [];
            this.skillID1 = [11001, 11002, 11003, 11004];
            this.skillID2 = [11201, 11202, 11203, 11204];
            this.skillID3 = [11301, 11306, 11307, 11308];
            this.skillID4 = [11302, 11303, 11304, 11305];
            loadDisplay("res/changejobbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("changejobbox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            this.bg = getDisplayChildByName("bg");
            this.mc_one = getDisplayChildByName("mc_one");
            this.mc_two = getDisplayChildByName("mc_two");
            this.mc_master = getDisplayChildByName("mc_master");
            this.mc1 = this.mc_one.getChildByName("mc1") as MovieClip;
            this.mc2 = this.mc_one.getChildByName("mc2") as MovieClip;
            this.mc3 = this.mc_one.getChildByName("mc3") as MovieClip;
            this.mc4 = this.mc_one.getChildByName("mc4") as MovieClip;
            this.mc_img1 = this.mc2.getChildByName("img") as MovieClip;
            this.imgBoss = this.mc2.getChildByName("imgBoss") as MovieClip;
            this.imgBoss.visible = false;
            this.mc_img2 = this.mc4.getChildByName("img") as MovieClip;
            this.img1 = new Image();
            this.img1.smoothing = true;
            this.img2 = new Image();
            this.img2.smoothing = true;
            this.mc_img1.addChild(this.img1);
            this.mc_img2.addChild(this.img2);
            this.effect = getDisplayChildByName("effect");
            this.mc_jobAtt = getDisplayChildByName("mc_jobAtt");
            this.txt_value1 = this.mc_jobAtt.getChildByName("txt_value1") as TextField;
            this.txt_value2 = this.mc_jobAtt.getChildByName("txt_value2") as TextField;
            this.txt_value3 = this.mc_jobAtt.getChildByName("txt_value3") as TextField;
            this.txt_condition1 = this.mc_one.getChildByName("txt_condition1") as TextField;
            this.txt_condition2 = this.mc_one.getChildByName("txt_condition2") as TextField;
            this.txt_condition3 = this.mc_one.getChildByName("txt_condition3") as TextField;
            this.txt_condition4 = this.mc_one.getChildByName("txt_condition4") as TextField;
            this.txt_condition1.addEventListener(TextEvent.LINK, this.__clickNPC);
            this.txt_condition2.addEventListener(TextEvent.LINK, this.__clickNPC);
            this.txt_condition3.addEventListener(TextEvent.LINK, this.__clickNPC);
            this.txt_condition4.addEventListener(TextEvent.LINK, this.__clickNPC);
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn4.visible = false;
            this.btn_compelete = new BaseButton(getDisplayChildByName("btn_compelete"));
            this.btn_compelete.visible = false;
            this.job1 = this.mc_jobAtt.getChildByName("job1") as MovieClip;
            this.job2 = this.mc_jobAtt.getChildByName("job2") as MovieClip;
            this.job3 = this.mc_two.getChildByName("job3") as MovieClip;
            this.job4 = this.mc_two.getChildByName("job4") as MovieClip;
            this.mc_video = (this.mc_two.getChildByName("mc_skillbg") as DisplayObjectContainer).getChildByName("mc_video") as MovieClip;
            this.btn_onekey = new BaseButton(this.mc_two.getChildByName("btn_onekey"));
            this.mc_npc = this.mc_two.getChildByName("mc_npc") as MovieClip;
            this.mc_step = this.mc_two.getChildByName("mc_step") as MovieClip;
            this.mc_shoeStep = new BaseButton(this.mc_step.getChildByName("mc_shoeStep"));
            this.mc_shoeNpc = new BaseButton(this.mc_npc.getChildByName("mc_shoeNpc"));
            this.mc_tips = this.mc_two.getChildByName("mc_tips") as MovieClip;
            this.mc_tips.visible = false;
            this.mc_shoeStep.addEvtListener(MouseEvent.CLICK, this.__clickShoe);
            this.mc_shoeNpc.addEvtListener(MouseEvent.CLICK, this.__clickShoe);
            this.btn_onekey.addEvtListener(MouseEvent.CLICK, this.__onekeyHandler);
            this.btn_onekey.addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.btn_onekey.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.skillItemSelectArray.push(this.mc_two.getChildByName("select1"), this.mc_two.getChildByName("select2"), this.mc_two.getChildByName("select3"), this.mc_two.getChildByName("select4"));
            var _loc_1:* = 0;
            while (_loc_1 < this.skillItemSelectArray.length)
            {
                
                this.skillItemSelectArray[_loc_1].visible = false;
                _loc_1++;
            }
            this.mc_shoe = new BaseButton(this.mc_one.getChildByName("mc_shoe"));
            ShoeTipUtil.tip(this.mc_shoe);
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_compelete.addEvtListener(MouseEvent.CLICK, this.__clickCompelete);
            this.mc_shoe.addEvtListener(MouseEvent.CLICK, this.__clickShoe);
            this.btnAry.push(this.btn1);
            this.btnAry.push(this.btn2);
            this.btnAry.push(this.btn3);
            this.btnAry.push(this.btn4);
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.btnAry[0].selected = true;
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            if (_loc_2 == 1)
            {
                this.changeJobSkill1 = new ChangeJobSkill1();
                this.mc_video.addChild(this.changeJobSkill1);
            }
            else if (_loc_2 == 2)
            {
                this.changeJobSkill2 = new ChangeJobSkill2();
                this.mc_video.addChild(this.changeJobSkill2);
            }
            else if (_loc_2 == 3)
            {
                _loc_6 = UserObj.getInstance().playerInfo.intelligence;
                _loc_7 = UserObj.getInstance().playerInfo.agile;
                if (_loc_6 > _loc_7)
                {
                    this.changeJobSkill3 = new ChangeJobSkill3();
                    this.mc_video.addChild(this.changeJobSkill3);
                }
                else
                {
                    this.changeJobSkill4 = new ChangeJobSkill4();
                    this.mc_video.addChild(this.changeJobSkill4);
                }
            }
            this.index = _loc_2;
            if (this.index > 2)
            {
                _loc_6 = UserObj.getInstance().playerInfo.intelligence;
                _loc_7 = UserObj.getInstance().playerInfo.agile;
                if (_loc_6 > _loc_7)
                {
                    this.index = 3;
                }
                else
                {
                    this.index = 4;
                }
            }
            this.txt_mastercondition1 = this.mc_master.getChildByName("txt_mastercondition1") as TextField;
            this.txt_mastercondition2 = this.mc_master.getChildByName("txt_mastercondition2") as TextField;
            this.mc_masterMC1 = this.mc_master.getChildByName("mc_masterMC1") as MovieClip;
            this.mc_masterMC2 = this.mc_master.getChildByName("mc_masterMC2") as MovieClip;
            this.mc_masterMC3 = this.mc_master.getChildByName("mc_masterMC3") as MovieClip;
            this.mc_masterMC1.mc_line1.mouseEnabled = false;
            this.mc_masterMC1.mc_line2.mouseEnabled = false;
            this.mc_masterMC2.mc_line1.mouseEnabled = false;
            this.mc_masterMC2.mc_line2.mouseEnabled = false;
            this.mc_masterMC3.mc_line1.mouseEnabled = false;
            this.mc_masterMC3.mc_line2.mouseEnabled = false;
            this.mc_masterjobAtt = this.mc_master.getChildByName("mc_masterjobAtt") as MovieClip;
            this.txt_mastervalue1 = this.mc_masterjobAtt.getChildByName("txt_value1") as TextField;
            this.txt_mastervalue2 = this.mc_masterjobAtt.getChildByName("txt_value2") as TextField;
            this.txt_mastervalue3 = this.mc_masterjobAtt.getChildByName("txt_value3") as TextField;
            this.masterjob1 = this.mc_masterjobAtt.getChildByName("job1") as MovieClip;
            this.masterjob2 = this.mc_masterjobAtt.getChildByName("job2") as MovieClip;
            this.txt_goto = this.mc_master.getChildByName("txt_goto") as TextField;
            this.txt_goto.addEventListener(TextEvent.LINK, this.__clickNPC);
            this.mc_mastershoe = new BaseButton(this.mc_master.getChildByName("mc_mastershoe"));
            this.mc_mastershoe.addEvtListener(MouseEvent.CLICK, this.__clickShoe);
            this.btn_info = new BaseButton(this.mc_master.getChildByName("btn_info"));
            var _loc_3:* = GlobalCfgObj.getInstance().getCfgById(280).q_string_value;
            StringTip.create(this.btn_info, _loc_3);
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                _loc_8 = 0;
                while (_loc_8 < this.masterStarNum)
                {
                    
                    _loc_9 = this.mc_master["mc_masterMC" + (_loc_4 + 1)].getChildByName("mc_master" + (_loc_8 + 1)) as MovieClip;
                    _loc_9.index = _loc_8 + 1;
                    this.mc_masterArr.push(_loc_9);
                    _loc_9.addEventListener(MouseEvent.CLICK, this.__clickMasterStar, false, 0, true);
                    _loc_9.addEventListener(MouseEvent.MOUSE_OVER, this.__overMC, false, 0, true);
                    _loc_9.addEventListener(MouseEvent.MOUSE_OUT, this.__outMC, false, 0, true);
                    _loc_8++;
                }
                _loc_4++;
            }
            var _loc_5:* = TaskModel.getInstance().curChangeJobLevel();
            if (TaskModel.getInstance().curChangeJobLevel())
            {
                this["btn" + _loc_5].dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                if (_loc_5 == 4)
                {
                    this.btn4.visible = true;
                    ChangeJobControl.getInstance().reqMasterChangeState();
                }
            }
            else
            {
                this.btn1.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        private function addEvents() : void
        {
            FrameworkGlobal.addMsgListen("masterUpdate", this.updateMC3);
            var _loc_1:* = 0;
            while (_loc_1 < this.masterStarNum)
            {
                
                _loc_1++;
            }
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.updateLevel);
            return;
        }// end function

        private function __clickMasterStar(event:MouseEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_2:* = int(event.target.index);
            var _loc_3:* = ChangeJobControl.getInstance().activeCount;
            if (_loc_2 <= _loc_3)
            {
            }
            else if (_loc_2 == (_loc_3 + 1))
            {
                _loc_4 = TaskModel.getInstance().curChangeJobTask();
                if (_loc_4 < 63000)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10001", "lang_changejob"));
                    return;
                }
                if (_loc_4 == 63000)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", "lang_changejob"));
                    return;
                }
                _loc_5 = UserObj.getInstance().playerInfo.jobkind;
                _loc_6 = QBaptismStarCfgObj.getInstance().getQBaptismStarInfoById(_loc_5 + "_" + (_loc_3 + 1));
                if (_loc_6)
                {
                    _loc_7 = _loc_6.q_consume.split("_");
                    _loc_8 = BackpackObj.getInstance().getItemCount(this.masterStarID);
                    _loc_9 = UserObj.getInstance().playerInfo.exp.toString();
                    if (_loc_8 >= int(_loc_7[0]))
                    {
                        ChangeJobControl.getInstance().reqActivateStar();
                    }
                    else
                    {
                        ChangeJobControl.getInstance().openChangejobSurePanel();
                    }
                }
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10004", "lang_changejob"));
            }
            return;
        }// end function

        public function shock() : void
        {
            MapControl.getInstance().currentGameScene.shock(5, 0);
            Effects.flash(this, 1, 1, 0.05, 6, 0, 5);
            return;
        }// end function

        private function checkCanActive() : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_1:* = ChangeJobControl.getInstance().activeCount;
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_3:* = QBaptismStarCfgObj.getInstance().getQBaptismStarInfoById(_loc_2 + "_" + (_loc_1 + 1));
            if (_loc_3)
            {
                _loc_4 = _loc_3.q_consume.split("_");
                _loc_5 = BackpackObj.getInstance().getItemCount(this.masterStarID);
                _loc_6 = UserObj.getInstance().playerInfo.exp.toString();
                if (_loc_5 >= int(_loc_4[0]) || _loc_6.length > _loc_4[1].length || _loc_6.length == _loc_4[1].length && _loc_6 > _loc_4[1])
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function getDes(param1:String) : String
        {
            var _loc_5:* = null;
            var _loc_2:* = "<font color=\'#FFD47F\'>";
            var _loc_3:* = param1.split(";");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4].split("_");
                if (_loc_5[0] == "1" && int(_loc_5[1]) > 0)
                {
                    _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("10005", "lang_changejob") + "<font color=\'#00ff00\'>+" + _loc_5[1] + "</font>\n");
                }
                else if (_loc_5[0] == "2" && int(_loc_5[1]) > 0)
                {
                    _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("10006", "lang_changejob") + "<font color=\'#00ff00\'>+" + _loc_5[1] + "</font>\n");
                }
                else if (_loc_5[0] == "3" && int(_loc_5[1]) > 0)
                {
                    _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("10007", "lang_changejob") + "<font color=\'#00ff00\'>+" + _loc_5[1] + "</font>\n");
                }
                _loc_4++;
            }
            _loc_2 = _loc_2 + "</font>";
            return _loc_2;
        }// end function

        private function getStr(param1:String) : String
        {
            var _loc_3:* = 0;
            var _loc_2:* = "";
            if (param1.length >= 9)
            {
                _loc_2 = param1.substring(0, param1.length - 8) + LanguageCfgObj.getInstance().getByIndex("10016", "lang_changejob");
                _loc_3 = int(param1.substring(param1.length - 8, param1.length - 4));
                if (_loc_3)
                {
                    _loc_2 = _loc_2 + (_loc_3 + LanguageCfgObj.getInstance().getByIndex("10017", "lang_changejob"));
                }
            }
            else
            {
                _loc_2 = int(int(param1) / 10000) + LanguageCfgObj.getInstance().getByIndex("10017", "lang_changejob");
            }
            return _loc_2;
        }// end function

        private function __onekeyHandler(event:MouseEvent) : void
        {
            var e:* = event;
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12390"), LanguageCfgObj.getInstance().getByIndex("11869"), null, function () : void
            {
                if (UserObj.getInstance().playerInfo.gold >= 1000)
                {
                    PlayerControl.getInstance().reqFinishThreeChangeJob();
                }
                else
                {
                    MapControl.getInstance().showRechargeD();
                }
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("12391"));
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.btnAry.length)
            {
                
                if (_loc_2 == _loc_3)
                {
                    this.btnAry[_loc_3].selected = true;
                }
                else
                {
                    this.btnAry[_loc_3].selected = false;
                }
                _loc_3++;
            }
            this._type = _loc_2 + 1;
            if (this._type == 4)
            {
                ChangeJobControl.getInstance().reqMasterChangeState();
            }
            this.update();
            return;
        }// end function

        private function __clickNPC(event:TextEvent = null) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_2:* = TaskModel.getInstance().curChangeJobTask();
            if (_loc_2)
            {
                _loc_3 = this.getDoingState();
                if (_loc_2 == 62002 && _loc_3 == 4)
                {
                    return;
                }
                _loc_4 = TaskManager.doJobTask(_loc_2, 1);
                if (_loc_4)
                {
                    this.close();
                }
                else
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11000"));
                }
            }
            return;
        }// end function

        private function __clickShoe(event:MouseEvent = null) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = TaskModel.getInstance().curChangeJobTask();
            if (_loc_2)
            {
                _loc_3 = TaskManager.doJobTask(_loc_2, 0);
                if (_loc_3)
                {
                    _loc_4 = UserObj.getInstance().playerInfo.vipid;
                    _loc_5 = BackpackObj.getInstance().getItemCount(200050);
                    if (_loc_4 > 0 || _loc_5 > 0)
                    {
                        TweenLite.delayedCall(0.5, this.close);
                    }
                }
                else
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11000"));
                }
            }
            return;
        }// end function

        private function __clickCompelete(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            if (this._type == 4)
            {
                TaskGlobal.protocol.reqMainTaskFinish(63001);
                TweenLite.delayedCall(1, this.update);
            }
            else
            {
                _loc_2 = TaskModel.getInstance().curChangeJobTask();
                if (_loc_2)
                {
                    TaskGlobal.protocol.reqMainTaskFinish(_loc_2);
                    if (_loc_2 == 62005)
                    {
                        this.close();
                    }
                    else
                    {
                        TweenLite.delayedCall(1, this.update);
                    }
                    TweenLite.delayedCall(0.2, this.playEffect);
                }
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this.mc_tips.visible = true;
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            this.mc_tips.visible = false;
            return;
        }// end function

        private function __overMC(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as MovieClip;
            var _loc_3:* = ChangeJobControl.getInstance().activeCount;
            if ((_loc_3 + 1) == _loc_2.index)
            {
                _loc_2.gotoAndStop(3);
            }
            return;
        }// end function

        private function __outMC(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as MovieClip;
            var _loc_3:* = ChangeJobControl.getInstance().activeCount;
            if ((_loc_3 + 1) == _loc_2.index)
            {
                _loc_2.gotoAndStop(2);
            }
            return;
        }// end function

        public function playEffect() : void
        {
            if (this._changeEffect == null)
            {
                this._changeEffect = new VMCView();
                this._changeEffect.auto = true;
            }
            this._changeEffect.loadRes("res/effect/classchange.png");
            this._changeEffect.updatePose("90", false, true, true);
            this._changeEffect.play();
            this._changeEffect.move(FrameworkGlobal.stage.stageWidth / 2, FrameworkGlobal.stage.stageHeight / 2);
            Global.popManager.addedChangeJobEffect(this._changeEffect);
            return;
        }// end function

        private function playWeaponEffect(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 < 3)
            {
                _loc_2 = UserObj.getInstance().playerInfo.jobkind;
                _loc_3 = "" + _loc_2 + param1;
                if (this._weaponEffect == null)
                {
                    this._weaponEffect = new VMCView();
                    this._weaponEffect.auto = true;
                }
                this._weaponEffect.loadRes("res/effect/changejob/job" + _loc_3 + ".png", null, true);
                this._weaponEffect.updatePose("90", true);
                this._weaponEffect.play();
                this.effect.addChild(this._weaponEffect);
            }
            else if (this._weaponEffect && this._weaponEffect.parent)
            {
                this.effect.removeChild(this._weaponEffect);
            }
            return;
        }// end function

        private function playBallEffect(param1:MovieClip) : void
        {
            if (this._ballEffect == null)
            {
                this._ballEffect = new VMCView();
                this._ballEffect.auto = true;
            }
            this._ballEffect.loadRes("res/effect/changejob/ball.png", null, true);
            this._ballEffect.updatePose("90", true);
            this._ballEffect.replay();
            this._ballEffect.visible = true;
            param1.effect.addChild(this._ballEffect);
            return;
        }// end function

        public function updateMC1() : void
        {
            var _loc_1:* = TaskModel.getInstance().curChangeJobTask();
            var _loc_2:* = TaskModel.getInstance().getTaskItemById(_loc_1);
            var _loc_3:* = _loc_2.complete;
            var _loc_4:* = UserObj.getInstance().playerInfo.job;
            if (UserObj.getInstance().playerInfo.job > 9)
            {
                _loc_4 = _loc_4 - 3;
            }
            var _loc_5:* = "";
            var _loc_6:* = TaskCfgObj.getInstance().getTaskById(_loc_1).q_consume_money;
            var _loc_7:* = UserObj.getInstance().playerInfo.level >= this.needLevel[2 * (this._type - 1) + 0];
            var _loc_8:* = UserObj.getInstance().playerInfo.money >= _loc_6;
            var _loc_9:* = NpcCfgObj.getInstance().getNpcByID(TaskCfgObj.getInstance().getTaskById(_loc_1).q_endnpc)._npcName;
            _loc_5 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12394"), [this.needLevel[2 * (this._type - 1) + 0]]) + (_loc_7 ? (LanguageCfgObj.getInstance().getByIndex("12392")) : (LanguageCfgObj.getInstance().getByIndex("12393"))) + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12395"), [_loc_6 / 10000]) + (_loc_8 ? (LanguageCfgObj.getInstance().getByIndex("12392")) : (LanguageCfgObj.getInstance().getByIndex("12393"))) + "<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12396"), [_loc_9]) + this["strArray" + _loc_4][0];
            this.txt_condition1.htmlText = _loc_5;
            if (this._type == 1 || this._type == 2)
            {
                _loc_5 = "<font color=\'#cccc00\'><a href=\'event:run\'><u>" + this["strArray" + _loc_4][1] + "</u></a></font>";
            }
            else if (this._type == 3)
            {
            }
            this.txt_condition2.htmlText = _loc_5;
            _loc_7 = UserObj.getInstance().playerInfo.level >= this.needLevel[2 * (this._type - 1) + 1];
            _loc_8 = UserObj.getInstance().playerInfo.money >= _loc_6;
            _loc_5 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12394"), [this.needLevel[2 * (this._type - 1) + 1]]) + (_loc_7 ? (LanguageCfgObj.getInstance().getByIndex("12392")) : (LanguageCfgObj.getInstance().getByIndex("12393")));
            if (_loc_6 > 0)
            {
                _loc_5 = _loc_5 + ("<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12395"), [_loc_6 / 10000]) + (_loc_8 ? (LanguageCfgObj.getInstance().getByIndex("12392")) : (LanguageCfgObj.getInstance().getByIndex("12393"))));
            }
            _loc_5 = _loc_5 + ("<br>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12396"), [_loc_9]) + this["strArray" + _loc_4][2]);
            this.txt_condition3.htmlText = _loc_5;
            if (this._type == 1 || this._type == 2)
            {
                _loc_5 = "<font color=\'#cccc00\'><a href=\'event:run\'><u>" + this["strArray" + _loc_4][3] + "</u></a></font>";
                StringTip.dispose(this.txt_condition4);
            }
            else if (this._type == 3)
            {
            }
            this.txt_condition4.htmlText = _loc_5;
            var _loc_10:* = this.getDoingState();
            var _loc_11:* = 1;
            while (_loc_11 <= 4)
            {
                
                this["txt_condition" + _loc_11].visible = _loc_10 == _loc_11;
                _loc_11++;
            }
            if (_loc_10 != 5)
            {
                this.mc_shoe.x = this["txt_condition" + _loc_10].x + this["txt_condition" + _loc_10].textWidth + 5;
            }
            if (_loc_10 == 1 || _loc_10 == 3)
            {
                this.mc_shoe.y = this["txt_condition" + _loc_10].y + this["txt_condition" + _loc_10].height - 25;
            }
            else if (_loc_10 == 2 || _loc_10 == 4)
            {
                this.mc_shoe.y = this["txt_condition" + _loc_10].y - 5;
            }
            this.mc_shoe.visible = _loc_10 != 5;
            this.btn_compelete.visible = _loc_10 == 5;
            if (_loc_10 == 5)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this.btn_compelete);
            }
            var _loc_12:* = false;
            var _loc_13:* = 1;
            while (_loc_13 <= 4)
            {
                
                if (_loc_13 < _loc_10)
                {
                    this.setState(this["mc" + _loc_13], 2);
                }
                else if (_loc_13 == _loc_10)
                {
                    this.setState(this["mc" + _loc_13], 1);
                    _loc_12 = true;
                }
                else
                {
                    this.setState(this["mc" + _loc_13], 3);
                }
                _loc_13++;
            }
            var _loc_14:* = this.getNotDoingState();
            if (this.getNotDoingState())
            {
                this.setTotalNotVisible();
                _loc_13 = 1;
                while (_loc_13 <= 4)
                {
                    
                    this.setState(this["mc" + _loc_13], _loc_14);
                    _loc_13++;
                }
                if (this._ballEffect)
                {
                    this._ballEffect.removeFromParent();
                }
            }
            if (!_loc_12)
            {
                if (this._ballEffect)
                {
                    this._ballEffect.removeFromParent();
                }
            }
            return;
        }// end function

        public function updateMC2() : void
        {
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_2:* = this.getDoingStateThree();
            this.mc_step.mc_step1.txt2.textColor = 14798751;
            this.mc_step.mc_step1.txt3.textColor = 14798751;
            this.mc_step.mc_step1.txt4.textColor = 14798751;
            this.mc_step.mc_step2.txt2.textColor = 14798751;
            this.mc_step.mc_step2.txt3.textColor = 14798751;
            this.mc_step.mc_step2.txt4.textColor = 14798751;
            this.mc_step.mc_step3.txt2.textColor = 14798751;
            this.mc_step.mc_step3.txt3.textColor = 14798751;
            this.mc_step.mc_step3.txt4.textColor = 14798751;
            this.mc_step.mc_step1.txt2.text = LanguageCfgObj.getInstance().getByIndex("12397");
            var _loc_3:* = BackpackObj.getInstance().getItemCount(600001);
            _loc_3 = _loc_3 >= 200 ? (200) : (_loc_3);
            var _loc_4:* = _loc_3 >= 200;
            var _loc_5:* = _loc_3 >= 200 ? (65280) : (16711680);
            this.mc_step.mc_step1.txt3.textColor = _loc_5;
            if (_loc_2 > 2)
            {
                this.mc_step.mc_step1.txt3.text = LanguageCfgObj.getInstance().getByIndex("12180");
            }
            else
            {
                this.mc_step.mc_step1.txt3.text = _loc_3 + "/200" + (_loc_4 ? (LanguageCfgObj.getInstance().getByIndex("12398")) : (LanguageCfgObj.getInstance().getByIndex("12399")));
            }
            this.mc_step.mc_step1.txt4.text = LanguageCfgObj.getInstance().getByIndex("12400") + this.needLevel2[0];
            var _loc_6:* = UserObj.getInstance().playerInfo.level >= this.needLevel2[0];
            _loc_5 = UserObj.getInstance().playerInfo.level >= this.needLevel2[0] ? (65280) : (16711680);
            this.mc_step.mc_step1.txt4.textColor = _loc_5;
            this.mc_step.mc_step2.txt2.text = LanguageCfgObj.getInstance().getByIndex("12401");
            _loc_3 = BackpackObj.getInstance().getItemCount(600002);
            _loc_3 = _loc_3 >= 100 ? (100) : (_loc_3);
            _loc_4 = _loc_3 >= 100;
            _loc_5 = _loc_4 ? (65280) : (16711680);
            this.mc_step.mc_step2.txt3.textColor = _loc_5;
            if (_loc_2 > 4)
            {
                this.mc_step.mc_step2.txt3.text = LanguageCfgObj.getInstance().getByIndex("12402");
            }
            else
            {
                this.mc_step.mc_step2.txt3.text = _loc_3 + "/100" + (_loc_4 ? (LanguageCfgObj.getInstance().getByIndex("12398")) : (LanguageCfgObj.getInstance().getByIndex("12399")));
            }
            this.mc_step.mc_step2.txt4.text = LanguageCfgObj.getInstance().getByIndex("12400") + this.needLevel2[1];
            _loc_6 = UserObj.getInstance().playerInfo.level >= this.needLevel2[1];
            _loc_5 = _loc_6 ? (65280) : (16711680);
            this.mc_step.mc_step2.txt4.textColor = _loc_5;
            this.mc_step.mc_step3.txt2.text = LanguageCfgObj.getInstance().getByIndex("12403");
            _loc_3 = BackpackObj.getInstance().getItemCount(600004);
            _loc_3 = _loc_3 >= 40 ? (40) : (_loc_3);
            _loc_4 = _loc_3 >= 40;
            _loc_5 = _loc_4 ? (65280) : (16711680);
            this.mc_step.mc_step3.txt3.textColor = _loc_5;
            this.mc_step.mc_step3.txt3.text = _loc_3 + "/40" + (_loc_4 ? (LanguageCfgObj.getInstance().getByIndex("12398")) : (LanguageCfgObj.getInstance().getByIndex("12399")));
            this.mc_step.mc_step3.txt4.text = LanguageCfgObj.getInstance().getByIndex("12400") + this.needLevel2[2];
            _loc_6 = UserObj.getInstance().playerInfo.level >= this.needLevel2[2];
            _loc_5 = _loc_6 ? (65280) : (16711680);
            this.mc_step.mc_step3.txt4.textColor = _loc_5;
            this.mc_step.mc_step1.txt_value1.text = "+" + this["addValue3" + _loc_1][0];
            this.mc_step.mc_step1.txt_value2.text = "+" + this["addValue3" + _loc_1][1];
            this.mc_step.mc_step1.txt_value3.text = "+" + this["addValue3" + _loc_1][2];
            this.mc_step.mc_step2.txt_value1.text = "+" + this["addValue3" + _loc_1][3];
            this.mc_step.mc_step2.txt_value2.text = "+" + this["addValue3" + _loc_1][4];
            this.mc_step.mc_step2.txt_value3.text = "+" + this["addValue3" + _loc_1][5];
            this.mc_step.mc_step3.txt_value1.text = "+" + this["addValue3" + _loc_1][6];
            this.mc_step.mc_step3.txt_value2.text = "+" + this["addValue3" + _loc_1][7];
            this.mc_step.mc_step3.txt_value3.text = "+" + this["addValue3" + _loc_1][8];
            this.mc_step.mc_step1.mc1.width = 0;
            this.mc_step.mc_step1.mc2.width = 0;
            this.mc_step.mc_step1.mc3.width = 0;
            this.mc_step.mc_step2.mc1.width = 0;
            this.mc_step.mc_step2.mc2.width = 0;
            this.mc_step.mc_step2.mc3.width = 0;
            this.mc_step.mc_step3.mc1.width = 0;
            this.mc_step.mc_step3.mc2.width = 0;
            this.mc_step.mc_step3.mc3.width = 0;
            var _loc_7:* = this["addValue3" + _loc_1][0] / (this["addValue3" + _loc_1][0] + this["addValue3" + _loc_1][3] + this["addValue3" + _loc_1][6]);
            var _loc_8:* = this["addValue3" + _loc_1][1] / (this["addValue3" + _loc_1][1] + this["addValue3" + _loc_1][4] + this["addValue3" + _loc_1][7]);
            var _loc_9:* = this["addValue3" + _loc_1][2] / (this["addValue3" + _loc_1][2] + this["addValue3" + _loc_1][5] + this["addValue3" + _loc_1][8]);
            var _loc_10:* = (this["addValue3" + _loc_1][0] + this["addValue3" + _loc_1][3]) / (this["addValue3" + _loc_1][0] + this["addValue3" + _loc_1][3] + this["addValue3" + _loc_1][6]);
            var _loc_11:* = (this["addValue3" + _loc_1][1] + this["addValue3" + _loc_1][4]) / (this["addValue3" + _loc_1][1] + this["addValue3" + _loc_1][4] + this["addValue3" + _loc_1][7]);
            var _loc_12:* = (this["addValue3" + _loc_1][2] + this["addValue3" + _loc_1][5]) / (this["addValue3" + _loc_1][2] + this["addValue3" + _loc_1][5] + this["addValue3" + _loc_1][8]);
            var _loc_13:* = 1;
            var _loc_14:* = 1;
            var _loc_15:* = 1;
            TweenLite.to(this.mc_step.mc_step1.mc1, 0.8, {width:_loc_7 * 82});
            TweenLite.to(this.mc_step.mc_step1.mc2, 0.8, {width:_loc_8 * 82});
            TweenLite.to(this.mc_step.mc_step1.mc3, 0.8, {width:_loc_9 * 82});
            TweenLite.to(this.mc_step.mc_step2.mc1, 0.8, {width:_loc_10 * 82});
            TweenLite.to(this.mc_step.mc_step2.mc2, 0.8, {width:_loc_11 * 82});
            TweenLite.to(this.mc_step.mc_step2.mc3, 0.8, {width:_loc_12 * 82});
            TweenLite.to(this.mc_step.mc_step3.mc1, 0.8, {width:_loc_13 * 82});
            TweenLite.to(this.mc_step.mc_step3.mc2, 0.8, {width:_loc_14 * 82});
            TweenLite.to(this.mc_step.mc_step3.mc3, 0.8, {width:_loc_15 * 82});
            if (_loc_2 == 0)
            {
                this.mc_npc.visible = true;
                this.mc_step.visible = false;
                this.mc_shoeNpc.visible = false;
                this.btn_onekey.visible = false;
                _loc_17 = ChangeJobControl.getInstance();
                if (_loc_17.hasChange3)
                {
                    this.showNpc(3);
                }
                else
                {
                    this.showNpc(1);
                }
            }
            else if (_loc_2 == 1 || _loc_2 == 3 || _loc_2 == 5)
            {
                this.mc_npc.visible = true;
                this.mc_step.visible = false;
                this.mc_shoeNpc.visible = true;
                this.btn_onekey.visible = true;
                this.showNpc(2);
            }
            else if (_loc_2 == 2 || _loc_2 == 4 || _loc_2 == 6)
            {
                this.mc_npc.visible = false;
                this.mc_step.visible = true;
                this.mc_shoeNpc.visible = false;
                this.btn_onekey.visible = true;
            }
            else if (_loc_2 == 7)
            {
                this.mc_npc.visible = true;
                this.mc_step.visible = false;
                this.mc_shoeNpc.visible = false;
                this.btn_onekey.visible = false;
                this.showNpc(3);
            }
            this.btn_compelete.visible = false;
            if (_loc_2 == 6)
            {
                if (this.mc_step.mc_step3.txt3.textColor == 65280 && this.mc_step.mc_step3.txt4.textColor == 65280)
                {
                    this.btn_onekey.visible = false;
                    this.btn_compelete.visible = true;
                }
            }
            if (_loc_2 == 2)
            {
                this.mc_shoeStep.x = 92;
                this.mc_shoeStep.y = 15;
                this.setStateThree(_loc_2);
            }
            else if (_loc_2 == 4)
            {
                this.mc_shoeStep.x = 92;
                this.mc_shoeStep.y = 145;
                this.setStateThree(_loc_2);
            }
            else if (_loc_2 == 6)
            {
                this.mc_shoeStep.x = 92;
                this.mc_shoeStep.y = 283;
                this.setStateThree(_loc_2);
            }
            if (!this.skillItem1)
            {
                this.skillItem1 = new ShortcutBox("");
                this.skillItem2 = new ShortcutBox("");
                this.skillItem3 = new ShortcutBox("");
                this.skillItem4 = new ShortcutBox("");
                this.skillItem1.isNum = false;
                this.skillItem2.isNum = false;
                this.skillItem3.isNum = false;
                this.skillItem4.isNum = false;
                this.skillItem1.isMenu = false;
                this.skillItem2.isMenu = false;
                this.skillItem3.isMenu = false;
                this.skillItem4.isMenu = false;
                this.skillItem1.canDrag = false;
                this.skillItem2.canDrag = false;
                this.skillItem3.canDrag = false;
                this.skillItem4.canDrag = false;
                _loc_18 = SkillCfgObj.getInstance().getSkillInfoById(this["skillID" + this.index][0]);
                this.skillItem1.clean();
                this.skillItem1.info = _loc_18;
                _loc_18 = SkillCfgObj.getInstance().getSkillInfoById(this["skillID" + this.index][1]);
                this.skillItem2.clean();
                this.skillItem2.info = _loc_18;
                _loc_18 = SkillCfgObj.getInstance().getSkillInfoById(this["skillID" + this.index][2]);
                this.skillItem3.clean();
                this.skillItem3.info = _loc_18;
                _loc_18 = SkillCfgObj.getInstance().getSkillInfoById(this["skillID" + this.index][3]);
                this.skillItem4.clean();
                this.skillItem4.info = _loc_18;
                this.skillItem1.image.setSize(54, 54);
                this.skillItem2.image.setSize(54, 54);
                this.skillItem3.image.setSize(54, 54);
                this.skillItem4.image.setSize(54, 54);
                this.mc_two.skillItem1.addChild(this.skillItem1);
                this.mc_two.skillItem2.addChild(this.skillItem2);
                this.mc_two.skillItem3.addChild(this.skillItem3);
                this.mc_two.skillItem4.addChild(this.skillItem4);
                this.skillItemArray.push(this.skillItem1, this.skillItem2, this.skillItem3, this.skillItem4);
                this.skillItem1.addEvtListener(MouseEvent.CLICK, this.__clickSkillItem);
                this.skillItem2.addEvtListener(MouseEvent.CLICK, this.__clickSkillItem);
                this.skillItem3.addEvtListener(MouseEvent.CLICK, this.__clickSkillItem);
                this.skillItem4.addEvtListener(MouseEvent.CLICK, this.__clickSkillItem);
            }
            var _loc_16:* = 0;
            while (_loc_16 < this.skillItemSelectArray.length)
            {
                
                this.skillItemSelectArray[_loc_16].visible = false;
                _loc_16++;
            }
            this.skillItemSelectArray[0].visible = true;
            this.showVideo();
            return;
        }// end function

        public function updateMC3(event:Event = null) : void
        {
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_3:* = 1;
            while (_loc_3 <= 3)
            {
                
                if (_loc_3 == _loc_2)
                {
                    this["mc_masterMC" + _loc_3].visible = true;
                }
                else
                {
                    this["mc_masterMC" + _loc_3].visible = false;
                }
                _loc_3++;
            }
            var _loc_4:* = ChangeJobControl.getInstance().activeCount;
            if (ChangeJobControl.getInstance().activeCount > 1)
            {
                this["mc_masterMC" + _loc_2].mc_line1.mc_mask.gotoAndStop((_loc_4 - 1));
                this["mc_masterMC" + _loc_2].mc_line1.visible = true;
            }
            else
            {
                this["mc_masterMC" + _loc_2].mc_line1.visible = false;
            }
            if (_loc_4 < 20)
            {
                this["mc_masterMC" + _loc_2].mc_line2.mc_mask.gotoAndStop(_loc_4);
                this["mc_masterMC" + _loc_2].mc_line2.visible = true;
            }
            else
            {
                this["mc_masterMC" + _loc_2].mc_line2.visible = false;
            }
            this.txt_mastercondition1.text = _loc_4 + "/" + this.masterStarNum + (_loc_4 >= this.masterStarNum ? ("√") : (LanguageCfgObj.getInstance().getByIndex("10008", "lang_changejob")));
            this.txt_mastercondition2.text = UserObj.getInstance().playerInfo.level + "/" + Params.MASTER_CHANGE_LEVEL + (UserObj.getInstance().playerInfo.level >= Params.MASTER_CHANGE_LEVEL ? ("√") : (LanguageCfgObj.getInstance().getByIndex("10008", "lang_changejob")));
            if (_loc_4 >= this.masterStarNum)
            {
                this.txt_mastercondition1.textColor = 65280;
            }
            else
            {
                this.txt_mastercondition1.textColor = 16711680;
            }
            if (UserObj.getInstance().playerInfo.level >= Params.MASTER_CHANGE_LEVEL)
            {
                this.txt_mastercondition2.textColor = 65280;
            }
            else
            {
                this.txt_mastercondition2.textColor = 16711680;
            }
            var _loc_5:* = TaskModel.getInstance().curChangeJobTask();
            var _loc_6:* = NpcCfgObj.getInstance().getNpcByID(TaskCfgObj.getInstance().getTaskById(63000).q_endnpc)._npcName;
            var _loc_7:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12396"), [_loc_6]);
            this.txt_goto.htmlText = _loc_7;
            this.mc_mastershoe.x = this.txt_goto.x + this.txt_goto.textWidth + 5;
            var _loc_8:* = TaskModel.getInstance().getTaskItemById(63000);
            if (TaskModel.getInstance().getTaskItemById(63000))
            {
                this.mc_mastershoe.visible = true;
            }
            else
            {
                this.mc_mastershoe.visible = false;
                this.txt_goto.htmlText = _loc_7 + "<font color=\'#00ff00\'>√</font>";
            }
            var _loc_9:* = 0;
            while (_loc_9 < this.masterStarNum)
            {
                
                _loc_13 = QBaptismStarCfgObj.getInstance().getQBaptismStarInfoById(_loc_2 + "_" + (_loc_9 + 1));
                if (_loc_9 < _loc_4)
                {
                    if (_loc_13)
                    {
                        _loc_14 = "<font color=\'#00FF00\'>" + _loc_13.q_name + "</font>" + LanguageCfgObj.getInstance().getByIndex("10011", "lang_changejob") + this.getDes(_loc_13.q_add_attribute) + "<font color=\'#00FF00\'>" + LanguageCfgObj.getInstance().getByIndex("10012", "lang_changejob") + "</font>";
                        StringTip.create(this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)], _loc_14);
                        this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)].gotoAndStop(4);
                    }
                }
                else if (_loc_9 == _loc_4)
                {
                    if (_loc_13)
                    {
                        _loc_15 = _loc_13.q_consume.split("_")[0];
                        _loc_16 = this.getStr(_loc_13.q_consume.split("_")[1]);
                        _loc_14 = "<font color=\'#00FF00\'>" + _loc_13.q_name + "</font>" + LanguageCfgObj.getInstance().getByIndex("10011", "lang_changejob") + this.getDes(_loc_13.q_add_attribute) + LanguageCfgObj.getInstance().getByIndex("10013", "lang_changejob") + "<font color=\'#00FF00\'>" + _loc_15 + "</font>" + LanguageCfgObj.getInstance().getByIndex("10014", "lang_changejob") + "<font color=\'#00FF00\'>" + _loc_16 + "</font>";
                        _loc_14 = _loc_14 + ("<font color=\'#ff0000\'><br><br>" + LanguageCfgObj.getInstance().getByIndex("10018", "lang_changejob") + ChangeJobControl.getInstance().prob + "%</font>");
                        StringTip.create(this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)], _loc_14);
                        this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)].gotoAndStop(2);
                        this.curMasterStar = _loc_9;
                        if (!ChangeJobControl.getInstance().isActiviteBack && _loc_4 < 20 && event)
                        {
                            this.addActiviteEffect();
                        }
                    }
                }
                else if (_loc_13)
                {
                    _loc_15 = _loc_13.q_consume.split("_")[0];
                    _loc_16 = this.getStr(_loc_13.q_consume.split("_")[1]);
                    _loc_14 = "<font color=\'#00FF00\'>" + _loc_13.q_name + "</font>" + LanguageCfgObj.getInstance().getByIndex("10011", "lang_changejob") + this.getDes(_loc_13.q_add_attribute) + LanguageCfgObj.getInstance().getByIndex("10013", "lang_changejob") + "<font color=\'#00FF00\'>" + _loc_15 + "</font>" + LanguageCfgObj.getInstance().getByIndex("10014", "lang_changejob") + "<font color=\'#00FF00\'>" + _loc_16 + "</font>";
                    StringTip.create(this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)], _loc_14);
                    this.mc_masterArr[_loc_9 + this.masterStarNum * (_loc_2 - 1)].gotoAndStop(1);
                }
                _loc_9++;
            }
            var _loc_10:* = UserObj.getInstance().playerInfo.exp.toNumber();
            var _loc_11:* = LevelExpCfgObj.getInstance().getExpByLevel(UserObj.getInstance().playerInfo.job, Params.MASTER_CHANGE_LEVEL);
            var _loc_12:* = _loc_10 >= _loc_11;
            this.btn_compelete.visible = _loc_4 == this.masterStarNum && UserObj.getInstance().playerInfo.level >= Params.MASTER_CHANGE_LEVEL && _loc_5 == 63001;
            return;
        }// end function

        public function updateLevel(event:RoleEvent = null) : void
        {
            if (!this.stage)
            {
                return;
            }
            this.txt_mastercondition2.text = UserObj.getInstance().playerInfo.level + "/" + Params.MASTER_CHANGE_LEVEL + (UserObj.getInstance().playerInfo.level >= Params.MASTER_CHANGE_LEVEL ? ("√") : (LanguageCfgObj.getInstance().getByIndex("10008", "lang_changejob")));
            if (UserObj.getInstance().playerInfo.level >= Params.MASTER_CHANGE_LEVEL)
            {
                this.txt_mastercondition2.textColor = 65280;
            }
            else
            {
                this.txt_mastercondition2.textColor = 16711680;
            }
            return;
        }// end function

        public function playFailEffect() : void
        {
            if (this.effectFail == null)
            {
                this.effectFail = new VMCView();
                this.effectFail.auto = true;
            }
            this.effectFail.loadRes("res/effect/changejob/changefail.png");
            this.effectFail.updatePose("90", false, false, true);
            this.effectFail.replay();
            this.effectFail.move(17, -30);
            if (this.effectFail2 == null)
            {
                this.effectFail2 = new VMCView();
                this.effectFail2.auto = true;
            }
            this.effectFail2.loadRes("res/effect/changejob/changefaileffect.png");
            this.effectFail2.updatePose("90", false, false, true);
            this.effectFail2.replay();
            this.effectFail2.move(17, 17);
            var _loc_1:* = UserObj.getInstance().playerInfo.jobkind;
            this.mc_masterArr[this.curMasterStar + this.masterStarNum * (_loc_1 - 1)].addChild(this.effectFail);
            this.mc_masterArr[this.curMasterStar + this.masterStarNum * (_loc_1 - 1)].addChild(this.effectFail2);
            return;
        }// end function

        private function addActiviteEffect(event:Event = null) : void
        {
            if (this.effect1 == null)
            {
                this.effect1 = new VMCView();
                this.effect1.auto = true;
            }
            this.effect1.loadRes("res/effect/changejob/activite.png", null, true);
            this.effect1.updatePose("90", true);
            this.effect1.replay();
            this.effect1.move(17, 17);
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_3:* = ChangeJobControl.getInstance().activeCount;
            if (this.mc_masterArr[_loc_3 + this.masterStarNum * (_loc_2 - 1)])
            {
                this.mc_masterArr[_loc_3 + this.masterStarNum * (_loc_2 - 1)].addChildAt(this.effect1, 0);
            }
            return;
        }// end function

        public function playSuccessEffect() : void
        {
            if (this.effect1 && this.effect1.parent)
            {
                this.effect1.removeFromParent();
            }
            if (this.effect2 == null)
            {
                this.effect2 = new VMCView();
                this.effect2.auto = true;
            }
            this.effect2.loadRes("res/effect/changejob/bomb.png");
            this.effect2.updatePose("90", false, false, true);
            this.effect2.replay();
            this.effect2.move(17, 17);
            if (this.curMasterStar != 19)
            {
                this.effect2.addEvtListener(Event.COMPLETE, this.playFlyEffect);
            }
            else
            {
                this.effect2.removeEvtListener(Event.COMPLETE, this.playFlyEffect);
            }
            var _loc_1:* = UserObj.getInstance().playerInfo.jobkind;
            this.mc_masterArr[this.curMasterStar + this.masterStarNum * (_loc_1 - 1)].addChild(this.effect2);
            this.saveNum = this.curMasterStar;
            return;
        }// end function

        private function playFlyEffect(event:Event = null) : void
        {
            if (this.effect31 == null)
            {
                this.effect31 = new Image();
                this.effect32 = new Image();
                this.effect33 = new Image();
                this.effect34 = new Image();
            }
            this.effect31.load("res/effect/changejob/single.png");
            this.effect32.load("res/effect/changejob/single.png");
            this.effect33.load("res/effect/changejob/single.png");
            this.effect34.load("res/effect/changejob/single.png");
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            var _loc_3:* = this.mc_masterArr[this.saveNum + this.masterStarNum * (_loc_2 - 1)].x - 8;
            var _loc_4:* = this.mc_masterArr[this.saveNum + this.masterStarNum * (_loc_2 - 1)].y - 8;
            this.effect31.move(_loc_3, _loc_4);
            this.effect32.move(_loc_3, _loc_4);
            this.effect33.move(_loc_3, _loc_4);
            this.effect34.move(_loc_3, _loc_4);
            this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].parent.addChild(this.effect31);
            this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].parent.addChild(this.effect32);
            this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].parent.addChild(this.effect33);
            this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].parent.addChild(this.effect34);
            var _loc_5:* = this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].x - 8;
            var _loc_6:* = this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].y - 8;
            TweenMax.to(this.effect31, 0.5, new TweenMaxVars().bezier([{x:_loc_3 + 30, y:_loc_4 + 30}, {x:_loc_5, y:_loc_6}]));
            TweenMax.to(this.effect32, 0.5, new TweenMaxVars().bezier([{x:_loc_3 + 30, y:_loc_4 - 30}, {x:_loc_5, y:_loc_6}]));
            TweenMax.to(this.effect33, 0.5, new TweenMaxVars().bezier([{x:_loc_3 - 30, y:_loc_4 + 30}, {x:_loc_5, y:_loc_6}]));
            TweenMax.to(this.effect34, 0.5, new TweenMaxVars().bezier([{x:_loc_3 - 30, y:_loc_4 - 30}, {x:_loc_5, y:_loc_6}]));
            TweenLite.delayedCall(0.7, this.playOpenEffect);
            return;
        }// end function

        private function playOpenEffect(event:Event = null) : void
        {
            if (this.effect31 && this.effect31.parent)
            {
                this.effect31.parent.removeChild(this.effect31);
                this.effect32.parent.removeChild(this.effect32);
                this.effect33.parent.removeChild(this.effect33);
                this.effect34.parent.removeChild(this.effect34);
            }
            if (this.effect4 == null)
            {
                this.effect4 = new VMCView();
                this.effect4.auto = true;
            }
            this.effect4.loadRes("res/effect/changejob/open.png");
            this.effect4.updatePose("90", false, false, true);
            this.effect4.replay();
            this.effect4.move(17, 17);
            TweenLite.delayedCall(0.5, this.addActiviteEffect);
            if (this.effect5 == null)
            {
                this.effect5 = new VMCView();
                this.effect5.auto = true;
            }
            this.effect5.loadRes("res/effect/changejob/changesucc.png");
            this.effect5.updatePose("90", false, false, true);
            this.effect5.replay();
            this.effect5.move(17, 17);
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            this.mc_masterArr[(this.saveNum + 1) + this.masterStarNum * (_loc_2 - 1)].addChild(this.effect4);
            this.mc_masterArr[this.saveNum + this.masterStarNum * (_loc_2 - 1)].addChild(this.effect5);
            return;
        }// end function

        private function showVideo(param1:int = 1) : void
        {
            if (this.changeJobSkill1)
            {
                this.changeJobSkill1.showSkill(param1);
            }
            else if (this.changeJobSkill2)
            {
                this.changeJobSkill2.showSkill(param1);
            }
            else if (this.changeJobSkill3)
            {
                this.changeJobSkill3.showSkill(param1);
            }
            else if (this.changeJobSkill4)
            {
                this.changeJobSkill4.showSkill(param1);
            }
            return;
        }// end function

        private function __clickSkillItem(event:MouseEvent) : void
        {
            var _loc_2:* = this.skillItemArray.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.skillItemArray.length)
            {
                
                if (_loc_3 == _loc_2)
                {
                    this.skillItemSelectArray[_loc_3].visible = true;
                }
                else
                {
                    this.skillItemSelectArray[_loc_3].visible = false;
                }
                _loc_3++;
            }
            this.showVideo((_loc_2 + 1));
            return;
        }// end function

        private function setStateThree(param1:int) : void
        {
            var _loc_2:* = 65280;
            var _loc_3:* = 16711680;
            var _loc_4:* = 7105644;
            if (param1 == 2)
            {
                this.mc_step.mc_step2.txt2.textColor = _loc_4;
                this.mc_step.mc_step2.txt3.textColor = _loc_4;
                this.mc_step.mc_step2.txt4.textColor = _loc_4;
                this.mc_step.mc_step3.txt2.textColor = _loc_4;
                this.mc_step.mc_step3.txt3.textColor = _loc_4;
                this.mc_step.mc_step3.txt4.textColor = _loc_4;
                this.mc_step.mc_step1.mc_compelete.gotoAndStop(2);
                this.mc_step.mc_step2.mc_compelete.gotoAndStop(1);
                this.mc_step.mc_step3.mc_compelete.gotoAndStop(1);
                this.mc_step.mc_step1.mc_select.visible = true;
                this.mc_step.mc_step2.mc_select.visible = false;
                this.mc_step.mc_step3.mc_select.visible = false;
            }
            else if (param1 == 4)
            {
                this.mc_step.mc_step1.txt2.textColor = _loc_2;
                this.mc_step.mc_step1.txt3.textColor = _loc_2;
                this.mc_step.mc_step1.txt4.textColor = _loc_2;
                this.mc_step.mc_step3.txt2.textColor = _loc_4;
                this.mc_step.mc_step3.txt3.textColor = _loc_4;
                this.mc_step.mc_step3.txt4.textColor = _loc_4;
                this.mc_step.mc_step1.mc_compelete.gotoAndStop(3);
                this.mc_step.mc_step2.mc_compelete.gotoAndStop(2);
                this.mc_step.mc_step3.mc_compelete.gotoAndStop(1);
                this.mc_step.mc_step1.mc_select.visible = false;
                this.mc_step.mc_step2.mc_select.visible = true;
                this.mc_step.mc_step3.mc_select.visible = false;
            }
            else if (param1 == 6)
            {
                this.mc_step.mc_step1.txt2.textColor = _loc_2;
                this.mc_step.mc_step1.txt3.textColor = _loc_2;
                this.mc_step.mc_step1.txt4.textColor = _loc_2;
                this.mc_step.mc_step2.txt2.textColor = _loc_2;
                this.mc_step.mc_step2.txt3.textColor = _loc_2;
                this.mc_step.mc_step2.txt4.textColor = _loc_2;
                this.mc_step.mc_step1.mc_compelete.gotoAndStop(3);
                this.mc_step.mc_step2.mc_compelete.gotoAndStop(3);
                this.mc_step.mc_step3.mc_compelete.gotoAndStop(2);
                this.mc_step.mc_step1.mc_select.visible = false;
                this.mc_step.mc_step2.mc_select.visible = false;
                this.mc_step.mc_step3.mc_select.visible = true;
            }
            return;
        }// end function

        private function showNpc(param1:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_2:* = new NpcInfo();
            _loc_2.npcId = long.fromNumber(100000);
            var _loc_3:* = new NpcShowInfo();
            _loc_3.npcInfo = _loc_2;
            _loc_3.name = "";
            _loc_3.url = Params.ROLE_RES_PATH + "nm015";
            var _loc_4:* = Global.roleFactory.creatNpc(_loc_3);
            _loc_4.direct = 180;
            _loc_4.setAct(Params.ACTION_STAND_ID, true);
            _loc_4.auto = true;
            ToolKit.clearMcChild(this.mc_npc.npc);
            this.mc_npc.npc.addChild(_loc_4 as DisplayObject);
            if (param1 == 1)
            {
                this.mc_npc.txt.text = LanguageCfgObj.getInstance().getByIndex("12404");
            }
            else if (param1 == 3)
            {
                this.mc_npc.txt.text = LanguageCfgObj.getInstance().getByIndex("10010", "lang_changejob");
            }
            if (param1 == 2)
            {
                _loc_5 = TaskModel.getInstance().curChangeJobTask();
                _loc_6 = TaskModel.getInstance().getTaskItemById(_loc_5);
                _loc_7 = _loc_6.complete;
                if (_loc_5 == 62002 && !_loc_7)
                {
                    this.mc_npc.txt.text = LanguageCfgObj.getInstance().getByIndex("12405");
                    this.mc_shoeNpc.visible = false;
                }
                else if (_loc_5 == 62004 && !_loc_7)
                {
                    this.mc_npc.txt.text = LanguageCfgObj.getInstance().getByIndex("12406");
                    this.mc_shoeNpc.visible = false;
                }
                else
                {
                    this.mc_npc.txt.text = LanguageCfgObj.getInstance().getByIndex("12407");
                    this.mc_shoeNpc.visible = true;
                }
            }
            return;
        }// end function

        public function update(event:BossGuideEvent = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = UserObj.getInstance().playerInfo.jobkind;
            switch(this._type)
            {
                case 1:
                {
                    this.bg.gotoAndStop(1);
                    this.mc_one.visible = true;
                    this.mc_two.visible = false;
                    this.mc_jobAtt.visible = true;
                    this.mc_master.visible = false;
                    this.job1.gotoAndStop(_loc_2);
                    this.job2.gotoAndStop(_loc_2 + 3);
                    this.good1 = this.goodID1[0];
                    this.good2 = this.goodID1[_loc_2];
                    break;
                }
                case 2:
                {
                    this.bg.gotoAndStop(1);
                    this.mc_one.visible = true;
                    this.mc_two.visible = false;
                    this.mc_jobAtt.visible = true;
                    this.mc_master.visible = false;
                    this.job1.gotoAndStop(_loc_2 + 3);
                    this.job2.gotoAndStop(_loc_2 + 3);
                    this.good1 = this.goodID2[0];
                    this.good2 = this.goodID2[1];
                    break;
                }
                case 3:
                {
                    this.bg.gotoAndStop(2);
                    this.mc_one.visible = false;
                    this.mc_two.visible = true;
                    this.mc_jobAtt.visible = false;
                    this.mc_master.visible = false;
                    this.job3.gotoAndStop(_loc_2 + 3);
                    this.job4.gotoAndStop(_loc_2 + 6);
                    this.good1 = this.goodID2[0];
                    this.good2 = this.goodID3;
                    break;
                }
                case 4:
                {
                    this.bg.gotoAndStop(1);
                    this.mc_one.visible = false;
                    this.mc_two.visible = false;
                    this.mc_jobAtt.visible = false;
                    this.mc_master.visible = true;
                    this.masterjob1.gotoAndStop(_loc_2 + 6);
                    this.masterjob2.gotoAndStop(_loc_2 + 9);
                    this.good1 = this.masterStarID;
                    this.good2 = this.expID;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._type == 3 || this._type == 4)
            {
                if (this._type == 4)
                {
                    _loc_5 = 1;
                    while (_loc_5 <= 3)
                    {
                        
                        this["txt_mastervalue" + (4 - _loc_5)].text = "+" + QBaptismStarCfgObj.getInstance().getTotalByJob(_loc_2.toString(), _loc_5);
                        this.mc_masterjobAtt.getChildByName("mc" + _loc_5).width = 0;
                        TweenLite.to(this.mc_masterjobAtt.getChildByName("mc" + _loc_5), 0.8, {width:82});
                        _loc_5++;
                    }
                }
            }
            else
            {
                _loc_6 = PropUtil.createItemByCfg(this.good1);
                _loc_7 = new IconItem("");
                _loc_7.setWH(56, 56);
                _loc_7.setImageSize(56, 56);
                _loc_7.setInfo(_loc_6);
                ToolKit.clearMcChild(this.mc_img1);
                this.mc_img1.addChild(_loc_7);
                _loc_6 = PropUtil.createItemByCfg(this.good2);
                _loc_7 = new IconItem("");
                _loc_7.setWH(56, 56);
                _loc_7.setImageSize(56, 56);
                _loc_7.setInfo(_loc_6);
                ToolKit.clearMcChild(this.mc_img2);
                this.mc_img2.addChild(_loc_7);
                _loc_8 = 1;
                while (_loc_8 <= 3)
                {
                    
                    this["txt_value" + _loc_8].text = "+" + this["addValue" + this._type + _loc_2][(_loc_8 - 1)];
                    this.mc_jobAtt.getChildByName("mc" + _loc_8).width = 0;
                    TweenLite.to(this.mc_jobAtt.getChildByName("mc" + _loc_8), 0.8, {width:82});
                    _loc_8++;
                }
            }
            this.playWeaponEffect(this._type);
            var _loc_3:* = TaskModel.getInstance().curChangeJobTask();
            var _loc_4:* = ChangeJobControl.getInstance();
            if (_loc_3 == 63000 || _loc_3 == 63001)
            {
                var _loc_10:* = true;
                _loc_4.hasChange3 = true;
                _loc_4.hasChange2 = _loc_10;
                _loc_4.hasChange1 = _loc_10;
            }
            if (!_loc_3 || _loc_3 == 63000 || _loc_3 == 63001)
            {
                if (this._type == 1 && (_loc_4.hasChange1 || _loc_4.hasChange2 || _loc_4.hasChange3))
                {
                    _loc_9 = 1;
                    while (_loc_9 <= 4)
                    {
                        
                        this.setState(this["mc" + _loc_9], 2);
                        _loc_9++;
                    }
                    this.setTotalNotVisible();
                }
                else if (this._type == 2)
                {
                    _loc_9 = 1;
                    while (_loc_9 <= 4)
                    {
                        
                        this.setState(this["mc" + _loc_9], _loc_4.hasChange2 || _loc_4.hasChange3 ? (2) : (3));
                        _loc_9++;
                    }
                    this.setTotalNotVisible();
                }
                else if (this._type == 3)
                {
                    this.updateMC2();
                }
                else if (this._type == 4)
                {
                    this.updateMC3();
                }
                return;
            }
            switch(this._type)
            {
                case 1:
                case 2:
                {
                    this.updateMC1();
                    break;
                }
                case 3:
                {
                    this.updateMC2();
                    break;
                }
                case 4:
                {
                    this.updateMC3();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getDoingState() : int
        {
            var _loc_1:* = 1;
            var _loc_2:* = TaskModel.getInstance().curChangeJobTask();
            var _loc_3:* = TaskModel.getInstance().getTaskItemById(_loc_2);
            var _loc_4:* = _loc_3.complete;
            switch(_loc_2)
            {
                case 62000:
                case 61000:
                case 60000:
                {
                    _loc_1 = 1;
                    break;
                }
                case 62001:
                case 61001:
                case 60001:
                {
                    if (!_loc_4)
                    {
                        _loc_1 = 2;
                    }
                    else
                    {
                        _loc_1 = 3;
                    }
                    break;
                }
                case 62002:
                {
                    if (UserObj.getInstance().playerInfo.level < 310 || UserObj.getInstance().playerInfo.money < Params.MASTER_CHANGE_LEVEL)
                    {
                        _loc_1 = 3;
                    }
                    else if (!_loc_4)
                    {
                        _loc_1 = 4;
                    }
                    else
                    {
                        _loc_1 = 5;
                    }
                    break;
                }
                case 61002:
                case 60002:
                case 60003:
                case 60004:
                {
                    if (!_loc_4)
                    {
                        _loc_1 = 4;
                    }
                    else
                    {
                        _loc_1 = 5;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function getDoingStateThree() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = TaskModel.getInstance().curChangeJobTask();
            switch(_loc_2)
            {
                case 62000:
                {
                    _loc_1 = 1;
                    break;
                }
                case 62001:
                {
                    _loc_1 = 2;
                    break;
                }
                case 62002:
                {
                    _loc_1 = 3;
                    break;
                }
                case 62003:
                {
                    _loc_1 = 4;
                    break;
                }
                case 62004:
                {
                    _loc_1 = 5;
                    break;
                }
                case 62005:
                {
                    _loc_1 = 6;
                    break;
                }
                case 63000:
                case 63001:
                {
                    _loc_1 = 7;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function setState(param1:MovieClip, param2:int) : void
        {
            switch(param2)
            {
                case 1:
                {
                    param1.mc.gotoAndStop(1);
                    param1.mc_compelete.visible = false;
                    param1.filters = null;
                    ButtonFlickerControl.getInstance().addButtonFlicker(param1.img);
                    this.playBallEffect(param1);
                    break;
                }
                case 2:
                {
                    param1.mc.gotoAndStop(2);
                    param1.mc_compelete.visible = true;
                    param1.mc_compelete.gotoAndStop(2);
                    ButtonFlickerControl.getInstance().removeButtonFlicker(param1.img);
                    param1.filters = null;
                    break;
                }
                case 3:
                {
                    param1.mc_compelete.visible = true;
                    param1.mc_compelete.gotoAndStop(1);
                    param1.filters = [FrameworkGlobal.colorMat];
                    ButtonFlickerControl.getInstance().removeButtonFlicker(param1.img);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getNotDoingState() : int
        {
            var _loc_1:* = TaskModel.getInstance().curChangeJobLevel();
            var _loc_2:* = 0;
            if (this._type == 1)
            {
                if (_loc_1 == 1)
                {
                    _loc_2 = 0;
                }
                else if (_loc_1 == 2)
                {
                    _loc_2 = 2;
                }
                else if (_loc_1 == 3)
                {
                    _loc_2 = 2;
                }
            }
            if (this._type == 2)
            {
                if (_loc_1 == 1)
                {
                    _loc_2 = 3;
                }
                else if (_loc_1 == 2)
                {
                    _loc_2 = 0;
                }
                else if (_loc_1 == 3)
                {
                    _loc_2 = 2;
                }
            }
            if (this._type == 3)
            {
                if (_loc_1 == 1)
                {
                    _loc_2 = 3;
                }
                else if (_loc_1 == 2)
                {
                    _loc_2 = 3;
                }
                else if (_loc_1 == 3)
                {
                    _loc_2 = 0;
                }
            }
            return _loc_2;
        }// end function

        private function setTotalNotVisible() : void
        {
            this.txt_condition1.visible = false;
            this.txt_condition2.visible = false;
            this.txt_condition3.visible = false;
            this.txt_condition4.visible = false;
            this.mc_shoe.visible = false;
            this.btn_compelete.visible = false;
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
            var _loc_1:* = 0;
            super.open();
            if (UILoaded)
            {
                _loc_1 = TaskModel.getInstance().curChangeJobLevel();
                if (_loc_1)
                {
                    this["btn" + _loc_1].dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    if (_loc_1 == 4)
                    {
                        this.btn4.visible = true;
                        ChangeJobControl.getInstance().reqMasterChangeState();
                    }
                }
                else
                {
                    this.btn1.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                }
            }
            return;
        }// end function

    }
}
