package com.game
{
    import com.*;
    import com.f1.*;
    import com.f1.manager.*;
    import com.f1.manager.cursor.*;
    import com.f1.manager.pop.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.artifact.control.*;
    import com.game.facebook.control.*;
    import com.game.historymsg.control.*;
    import com.game.hotkeyguide.control.*;
    import com.game.login.control.*;
    import com.game.prompt.model.*;
    import com.game.protect.control.*;
    import com.game.role.*;
    import com.game.supervip.control.*;
    import com.game.worldlevel.control.*;
    import com.greensock.plugins.*;
    import com.net.*;
    import com.platform.*;
    import com.test.*;
    import com.util.smallglobal.*;
    import com.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import interfaces.game.*;

    public class GameModule extends BaseModule implements IGameModule
    {
        private var uiManager:UIManager;
        private var popManager:PopManager;
        private var primaryCursorManager:PrimaryCursorManager;
        private var _isFirstLogin:Boolean;

        public function GameModule()
        {
            Security.allowDomain("*");
            TweenPlugin.activate([FrameLabelPlugin, ColorTransformPlugin]);
            TweenPlugin.activate([TintPlugin]);
            BasicGlobal.gameModule = this;
            Global.roleFactory = new RoleModule();
            this._isFirstLogin = true;
            return;
        }// end function

        public function indexGame() : void
        {
            Log.log("GameModule.indexGame === begin");
            if (!FrameworkGlobal.published)
            {
                FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownStage);
            }
            var _loc_1:* = new UIManager(IndexSwf.instance.createLayer());
            this.uiManager = new UIManager(IndexSwf.instance.createLayer());
            Global.mainUIManager = _loc_1;
            var _loc_1:* = new PrimaryCursorManager(FrameworkGlobal.stage);
            this.primaryCursorManager = new PrimaryCursorManager(FrameworkGlobal.stage);
            Global.primaryCursorManager = _loc_1;
            var _loc_1:* = new PopManager(IndexSwf.instance);
            this.popManager = new PopManager(IndexSwf.instance);
            BasicGlobal.popManager = _loc_1;
            SimpleTip.init(FrameworkGlobal.stage);
            if (BasicGlobal.jinhui.clickStream)
            {
                MessagesModel.getInstance();
            }
            BasicGlobal.messagePool = new LoginMessagePool();
            LoginControl.getInstance().loginFinish();
            Log.log("GameModule.indexGame === end");
            return;
        }// end function

        public function initGame() : void
        {
            Log.log("GameModule.initGame === begin");
            BasicGlobal.messagePool = new MessagePool();
            HotkeyGuideControl.getInstance();
            ArtifactControl.getInstance();
            HistorymsgControl.getInstance();
            ProtectControl.getInstance();
            WorldLevelControl.getInstance();
            SupervipControl.getInstance();
            FacebookControl.getInstance();
            new SmallGlobalImpl();
            if (BasicGlobal.jinhui.menu)
            {
                new TestJinhui();
            }
            Platform.createInstance();
            this.GPUInitCallBack();
            Log.log("GameModule.initGame === end");
            return;
        }// end function

        private function GPUInitCallBack() : void
        {
            LoginControl.getInstance().loadFinish();
            var _loc_1:* = ToolKit.creatRect(0, 0, 10, 10, 3355443, -1, 1);
            FrameworkGlobal.stage.addChild(_loc_1);
            _loc_1.addEventListener(MouseEvent.CLICK, this.__checkDebuger);
            return;
        }// end function

        private function __checkDebuger(event:MouseEvent) : void
        {
            throw new Error("这是个debug版本,是否开启了硬件加速" + GPUManager.GPUEnable);
        }// end function

        public function resize() : void
        {
            if (this.uiManager)
            {
                this.uiManager.resize();
            }
            if (this.popManager)
            {
                this.popManager.resize();
            }
            if (GPUManager.GPUEnable)
            {
                GPUManager.getInstance().resize();
            }
            return;
        }// end function

        private function onMouseDownStage(event:MouseEvent) : void
        {
            Log.log("★" + McTrace.getDisplayObjectFolder(event.target));
            return;
        }// end function

        override public function traceOfDisplay(param1:DisplayObject) : String
        {
            switch(getQualifiedClassName(param1))
            {
                case "module.game.vgame.city.view.SceneItem::TransBtn":
                {
                    break;
                }
                case "module.game.bag::ItemPicContentCell":
                {
                    break;
                }
                case "module.game.view.hero::HeroFace_Cell":
                {
                    break;
                }
                case "module.game.city::SceneLoader":
                {
                    break;
                }
                case "module.game.view.hero::HeroSkillCell":
                {
                    return "技能: " + param1["_skillInfo"]["name"] + "Lv." + param1["_skillInfo"]["level"];
                }
                case "module.game.task::TaskCell":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function testWill() : void
        {
            return;
        }// end function

        public function testNeil() : void
        {
            return;
        }// end function

    }
}
