package com.game.task.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.game.bossrank.control.*;
    import com.game.bossrank.view.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.game.task.control.*;
    import com.game.task.events.*;
    import com.game.task.mediator.*;
    import com.game.task.model.*;
    import com.game.vip.control.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class FastTaskPanel extends BaseBox implements IGuide
    {
        public var mediator:FastTaskMediator;
        private var taskOpen:Boolean = true;
        public var btn_task:BaseButton;
        public var mc_icon:MovieClip;
        public var mc_name:MovieClip;
        public var txt_label1:TextField;
        public var txt_label2:TextField;
        public var txt_info:TextField;
        public var txt_task_desc:TextField;
        public var txt_task_name:TextField;
        public var txt_title:TextField;
        public var mc_shoe:BaseButton;
        public var btn_task_txt:TextField;
        public var btn_down:BaseButton;
        public var btn_up:BaseButton;
        public var mc_container:MovieClip;
        public var shoe1:BaseButton;
        public var shoe2:BaseButton;
        public var shoe3:BaseButton;
        public var shoe4:BaseButton;
        public var guide1:TextField;
        public var guide2:TextField;
        public var guide3:TextField;
        public var guide4:TextField;
        public var taskListContainer:List;
        private static var _instance:FastTaskPanel;

        public function FastTaskPanel()
        {
            loadDisplay("res/fast_task.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.showPanel();
            super.displayReady();
            this.mediator = new FastTaskMediator(this);
            return;
        }// end function

        public function showPanel() : void
        {
            if (TaskGlobal.task && TaskGlobal.task.taskId > 10068)
            {
                this.showFrame(1);
                return;
            }
            if (TaskModel.getInstance().mutishow)
            {
                this.showFrame(1);
            }
            else
            {
                this.showFrame(0);
                TaskGlobal.myEvt.addEventListener(TaskEvent.PANEL_UI_CHANGE, this.onChangeUI);
            }
            return;
        }// end function

        private function onChangeUI(event:TaskEvent) : void
        {
            TaskGlobal.myEvt.removeEventListener(TaskEvent.PANEL_UI_CHANGE, this.onChangeUI);
            this.showFrame(1);
            TweenLite.delayedCall(0.5, this.changeAndShow);
            return;
        }// end function

        private function changeAndShow() : void
        {
            setWH(width, height);
            var _loc_1:* = new LayoutInfo(Layout.RIGHT, 0, 150);
            this.setAttr("layoutInfo", _loc_1);
            Global.mainUIManager.layoutUI(this);
            this.mediator.showTask2();
            return;
        }// end function

        public function showFrame(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                initBaseBoxUI("FastTaskPanel1", 50);
                this.initUI1();
            }
            else
            {
                initBaseBoxUI("FastTaskPanel2", 50);
                this.initUI2();
            }
            this.txt_info = getDisplayChildByName("txt_info") as TextField;
            this.txt_title = getDisplayChildByName("txt_title") as TextField;
            this.txt_task_name = getDisplayChildByName("txt_task_name") as TextField;
            return;
        }// end function

        private function initUI1() : void
        {
            var _loc_1:* = getDisplayChildByName("btn_task");
            _loc_1.getChildByName("mc");
            _loc_1.mouseChildren = false;
            _loc_1.mouseEnabled = false;
            this.btn_task = new BaseButton(_loc_1);
            this.mc_shoe = new BaseButton(getDisplayChildByName("mc_shoe"));
            ShoeTipUtil.tip(this.mc_shoe);
            this.btn_task.addEventListener(MouseEvent.CLICK, this.goOnTask);
            this.btn_task_txt = getDisplayChildByName("txt");
            this.btn_task_txt.mouseEnabled = false;
            this.btn_task_txt.text = LanguageCfgObj.getInstance().getByIndex("11333");
            this.txt_task_desc = getDisplayChildByName("txt_task_desc") as TextField;
            this.txt_task_desc.text = "";
            this.txt_label1 = getDisplayChildByName("txt_label1") as TextField;
            this.txt_label1.autoSize = TextFieldAutoSize.LEFT;
            this.txt_label1.width = 195;
            this.txt_label2 = getDisplayChildByName("txt_label2") as TextField;
            this.txt_label2.text = "";
            this.mc_icon = getDisplayChildByName("mc_icon") as MovieClip;
            this.mc_name = getDisplayChildByName("mc_name") as MovieClip;
            var _loc_2:* = new Image();
            _loc_2.x = 4;
            _loc_2.y = 4;
            this.mc_icon.image = _loc_2;
            this.mc_icon.addChild(_loc_2);
            this.txt_label1.addEventListener(TextEvent.LINK, this.onLinkEventHandle);
            this.txt_label2.addEventListener(TextEvent.LINK, this.onLinkEventHandle);
            this.registerGuide();
            return;
        }// end function

        private function initUI2() : void
        {
            var _loc_1:* = display;
            var _loc_2:* = new BaseButton(getDisplayChildByName("mc_task"));
            StringTip.create(_loc_2, LanguageCfgObj.getInstance().getByIndex("11334"));
            _loc_2.addEventListener(MouseEvent.CLICK, this.onOpenTaskPanel);
            this.mc_container = getDisplayChildByName("mc_container") as MovieClip;
            this.btn_up = new BaseButton(getDisplayChildByName("btn_up"));
            this.btn_down = new BaseButton(getDisplayChildByName("btn_down"));
            this.btn_down.x = this.btn_up.x;
            this.btn_down.visible = false;
            this.btn_up.addEventListener(MouseEvent.CLICK, this.onClichHandle);
            this.btn_down.addEventListener(MouseEvent.CLICK, this.onClichHandle);
            FrameworkGlobal.addMsgListen("task_open", this.__taskOpen);
            FrameworkGlobal.addMsgListen("task_close", this.__taskClose);
            this.taskListContainer = new List(229, 184);
            this.taskListContainer.move(20, 4);
            this.mc_container.addChild(this.taskListContainer);
            this.shoe1 = new BaseButton(this.mc_container["mc_shoe1"]);
            this.shoe2 = new BaseButton(this.mc_container["mc_shoe2"]);
            this.shoe3 = new BaseButton(this.mc_container["mc_shoe3"]);
            this.shoe4 = new BaseButton(this.mc_container["mc_shoe4"]);
            this.guide1 = this.mc_container["guide1"];
            this.guide2 = this.mc_container["guide2"];
            this.guide3 = this.mc_container["guide3"];
            this.guide4 = this.mc_container["guide4"];
            this.registerGuide();
            return;
        }// end function

        private function goOnTask(event:MouseEvent) : void
        {
            this.mediator.goOnTask();
            return;
        }// end function

        private function onClichHandle(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            _loc_2 = BossDamageRankControl.getInstance().bossDamageRankView;
            switch(event.target)
            {
                case this.btn_up:
                {
                    this.btn_down.visible = true;
                    this.btn_up.visible = false;
                    this.mc_container.visible = false;
                    if (_loc_2 && _loc_2.parent)
                    {
                        _loc_2.y = -_loc_2.height;
                        FrameworkGlobal.sendMsg(new Event("bossinfo_open"));
                        Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 155 + _loc_2.height), GroupPanelType.GROUP_LEVEL1);
                    }
                    break;
                }
                case this.btn_down:
                {
                    this.btn_down.visible = false;
                    this.btn_up.visible = true;
                    this.mc_container.visible = true;
                    if (_loc_2 && _loc_2.parent)
                    {
                        _loc_2.y = -BossDamageRankView.TITLE_HEIGHT;
                        FrameworkGlobal.sendMsg(new Event("bossinfo_close"));
                        Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 155 + BossDamageRankView.TITLE_HEIGHT), GroupPanelType.GROUP_LEVEL1);
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

        private function __taskOpen(event:Event) : void
        {
            this.btn_down.visible = false;
            this.btn_up.visible = true;
            this.mc_container.visible = true;
            return;
        }// end function

        private function __taskClose(event:Event) : void
        {
            this.btn_down.visible = true;
            this.btn_up.visible = false;
            this.mc_container.visible = false;
            return;
        }// end function

        private function onLinkEventHandle(event:TextEvent) : void
        {
            TaskLinkEventManager.linkEventHandle(event);
            return;
        }// end function

        private function onOpenTaskPanel(event:MouseEvent) : void
        {
            TaskControl.getInstance().openOrClose();
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            BubbleTextControl.getInstance().setBubbleTextVisible(param1);
            if (param1)
            {
                GuideControl.getInstance().unHideArrow();
            }
            else
            {
                GuideControl.getInstance().hideArrow();
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this.btn_task, this, GuideConfigObj.getInstance().FAST_TASK_BTN_GUIDE_ID);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

        public static function getInstance() : FastTaskPanel
        {
            var _loc_1:* = _instance || new FastTaskPanel;
            _instance = _instance || new FastTaskPanel;
            return _loc_1;
        }// end function

    }
}
