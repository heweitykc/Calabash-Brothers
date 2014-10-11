package 
{
    import IndexSwf.*;
    import com.*;
    import com.adobe.crypto.*;
    import com.connect.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.events.net.*;
    import com.f1.interfaces.*;
    import com.f1.manager.*;
    import com.f1.manager.keyboard.*;
    import com.f1.manager.resource.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.login.control.*;
    import com.index.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class IndexSwf extends BaseScene
    {
        private var m_sound:Sound;
        private var connecter:IConnecter;
        private var loginOk:Boolean;
        private var loadOk:Boolean;
        private var loadingPanel:IndexLoadingPanel;
        private var loadingPanelOk:Boolean;
        private var gameModuleBa:ByteArray;
        private var text:TextField;
        public static var instance:IndexSwf;
        private static var LoginCfgBa:Class = IndexSwf_LoginCfgBa;

        public function IndexSwf()
        {
            Security.allowDomain("*");
            instance = this;
            Set.init();
            this.m_sound = new Sound();
            this.m_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, this.__soundEnterframe);
            this.m_sound.play();
            if (stage == null)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.__init);
            }
            else
            {
                this.__init();
            }
            return;
        }// end function

        private function __soundEnterframe(event:SampleDataEvent) : void
        {
            var _loc_2:* = 4096 * 4;
            event.data.length = 4096 * 4;
            event.data.position = _loc_2;
            return;
        }// end function

        protected function __init(event:Event = null) : void
        {
            this.loadLoginCfg();
            removeEventListener(Event.ADDED_TO_STAGE, this.__init);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.stageFocusRect = false;
            stage.addEventListener(Event.RESIZE, this.onStageResize);
            setWH(stage.stageWidth, stage.stageHeight);
            KeyboardManager.initialize(stage);
            IME.enabled = false;
            FrameworkGlobal.stage = stage;
            stage.addEventListener(MouseEvent.CLICK, this.onMouseClickStage);
            FrameworkGlobal.flashvars = root.loaderInfo.parameters;
            ParamParser.parse();
            this.connectServer();
            ClickStream.add(ClickStreamId.FLASH_STARTUP);
            Ticker.registerTimer(30, this.__jsHeartBeat);
            return;
        }// end function

        private function __jsHeartBeat() : void
        {
            JSCaller.heartBeat();
            return;
        }// end function

        private function connectServer() : void
        {
            var _loc_1:* = new Connecter();
            FrameworkGlobal.mainConnecter = new Connecter();
            this.connecter = _loc_1;
            if (this.connecter.isLive())
            {
                this.connectSuccess();
            }
            else
            {
                this.connecter.addConnection(Params.IP, Params.PORT, Params.SPORT, ServerID.MAINSVR);
                this.connecter.addEvtListener(ConnecterEvent.CONNECT, this.connectSuccess);
                this.connecter.addEvtListener(SocketEvent.ERROR, this.connectFail);
                this.connecter.addEvtListener(SocketEvent.CLOSED, this.connectClose);
                this.connecter.connect();
            }
            this.showText("<font size=\'22\'>" + LanguageCfgObj.getInstance().getByLoginIndex("1001") + "</font>");
            return;
        }// end function

        private function removeConnectEventListener() : void
        {
            if (this.connecter)
            {
                this.connecter.removeEvtListener(ConnecterEvent.CONNECT, this.connectSuccess);
                this.connecter.removeEvtListener(SocketEvent.ERROR, this.connectFail);
                this.connecter.removeEvtListener(SocketEvent.CLOSED, this.connectClose);
            }
            return;
        }// end function

        private function connectFail(event:SocketEvent = null) : void
        {
            this.showText(LanguageCfgObj.getInstance().getByLoginIndex("1000") + event.obj);
            JSCaller.GameReady(false);
            return;
        }// end function

        private function connectClose(event:SocketEvent = null) : void
        {
            this.showText(LanguageCfgObj.getInstance().getByLoginIndex("1002"));
            JSCaller.GameReady(false);
            return;
        }// end function

        private function connectSuccess(event:ConnecterEvent = null) : void
        {
            Log.log("index === 连接服务器成功");
            ClickStream.add(ClickStreamId.CONNECT_SERVER_OK);
            BasicGlobal.sceneManager = new SceneManager(createLayer());
            if (event.socketHandler.app == ServerID.MAINSVR)
            {
                this.login();
            }
            return;
        }// end function

        private function loadLoginCfg() : void
        {
            var _loc_1:* = new LoginCfgBa();
            _loc_1.uncompress();
            var _loc_2:* = _loc_1.readByte();
            var _loc_3:* = _loc_1.readUnsignedInt();
            CfgManager.getInstance().readCfg(_loc_1);
            return;
        }// end function

        private function login() : void
        {
            FrameworkGlobal.addMsgListen(GameEvent.LOGIN_FAIL, this.onLoginFail);
            FrameworkGlobal.addMsgListen(GameEvent.LOGIN_SUCCESS, this.onLoginOk);
            FrameworkGlobal.addMsgListen(GameEvent.REGISTER_PANEL_LOADED, this.initLoadHelper);
            if (Params.isPlatform)
            {
                this.platformLogin();
            }
            else if (BasicGlobal.jinhui.facebookLogin)
            {
                Params.facebookUserId = "1";
                Params.serverid = Params.zoneid.toString();
                Params.username = BasicGlobal.openid;
                Params.time = "2014-01-01 12:00:00";
                Params.isadult = "1";
                Params.loginType = "1";
                this.platformLogin();
            }
            else
            {
                RegistControl.getInstance().login();
            }
            return;
        }// end function

        private function platformLogin() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = Params.facebookUserId;
            if (_loc_2)
            {
                _loc_1 = "{\"pf\":\"fb\",\"uid\":\"" + _loc_2 + "\"}";
            }
            RegistControl.getInstance().platformLogin(Params.serverid, Params.username, Params.time, Params.isadult, Params.pfMD5Key, Params.loginType, _loc_1);
            return;
        }// end function

        private function onLoginFail(event:GameEvent) : void
        {
            this.unlistenLoginEvent();
            this.showText(event.obj);
            JSCaller.GameReady(false);
            return;
        }// end function

        private function onLoginOk(event:GameEvent) : void
        {
            Log.log("index === 登录角色成功");
            this.unlistenLoginEvent();
            this.loginOk = true;
            this.tryShowLoadingPanel();
            this.tryIndexGame();
            return;
        }// end function

        private function unlistenLoginEvent() : void
        {
            FrameworkGlobal.removeMsgListen(GameEvent.LOGIN_FAIL, this.onLoginFail);
            FrameworkGlobal.removeMsgListen(GameEvent.LOGIN_SUCCESS, this.onLoginOk);
            return;
        }// end function

        private function initLoadHelper(event:Event = null) : void
        {
            LoadHelper.init(Params.files_XML_path, this.onLoadHelperOk);
            return;
        }// end function

        private function onLoadHelperOk() : void
        {
            Log.log("index === 初始化资源加载器完毕");
            this.initLoadingPanel();
            return;
        }// end function

        private function initLoadingPanel() : void
        {
            this.loadingPanel = new IndexLoadingPanel();
            layoutMC(this.loadingPanel);
            this.loadingPanel.addEvtListener(UIEvent.RES_LOAD_COMPLETE, this.onLoadLoadingPanelOk);
            return;
        }// end function

        private function onLoadLoadingPanelOk(event:UIEvent) : void
        {
            Log.log("index === 初始化预加载界面完毕");
            this.loadingPanelOk = true;
            this.tryShowLoadingPanel();
            this.loadFiles();
            return;
        }// end function

        private function loadFiles() : void
        {
            LoadFiles.getInstance().startLoad(this.onLoadFilesOk, this.showProgress(LanguageCfgObj.getInstance().getByLoginIndex("1003")));
            return;
        }// end function

        private function onLoadFilesOk() : void
        {
            Log.log("index === 加载资源完毕");
            this.loadCfg();
            return;
        }// end function

        private function loadCfg() : void
        {
            CfgManager.getInstance().loadCfg(this.onLoadCfgOk, this.showProgress(LanguageCfgObj.getInstance().getByLoginIndex("1004")));
            return;
        }// end function

        private function onLoadCfgOk() : void
        {
            Log.log("index === 加载配置完毕");
            this.loadGameModule();
            return;
        }// end function

        private function loadGameModule() : void
        {
            VResManager.load("com/game/GameModule.swf", this.onLoadGameModuleOk, null, null, this.showProgress(LanguageCfgObj.getInstance().getByLoginIndex("1005")), false, true);
            return;
        }// end function

        private function onLoadGameModuleOk(param1:ByteArray) : void
        {
            Log.log("index === 加载主程序完毕");
            ClickStream.add(ClickStreamId.LOAD_RESOURCE_OK);
            this.gameModuleBa = param1;
            this.loadOk = true;
            this.tryIndexGame();
            return;
        }// end function

        private function tryShowLoadingPanel() : void
        {
            if (this.loginOk && this.loadingPanelOk)
            {
                this.showLoadingPanel();
            }
            return;
        }// end function

        private function showLoadingPanel() : void
        {
            addChild(this.loadingPanel);
            this.hideTxt();
            RegistControl.getInstance().disposeRegistScene();
            return;
        }// end function

        private function disposeLoadingPanel() : void
        {
            this.loadingPanel.removeFromParent(true);
            this.loadingPanel = null;
            return;
        }// end function

        private function dispose() : void
        {
            this.disposeLoadingPanel();
            this.hideTxt();
            this.removeConnectEventListener();
            return;
        }// end function

        private function tryIndexGame() : void
        {
            if (this.loginOk && this.loadOk)
            {
                addEventListener(Event.ENTER_FRAME, this.indexGame);
            }
            return;
        }// end function

        private function indexGame(event:Event = null) : void
        {
            Log.log("index === 开始引导主程序");
            removeEventListener(Event.ENTER_FRAME, this.indexGame);
            this.loadingPanel.setBgMsg(LanguageCfgObj.getInstance().getByLoginIndex("1006"));
            addEventListener(Event.ENTER_FRAME, this.parseCfgs);
            return;
        }// end function

        private function parseCfgs(event:Event = null) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.parseCfgs);
            CfgManager.getInstance().parseCfgs();
            Log.log("index === 读取配置完毕");
            this.loadingPanel.setBgMsg(LanguageCfgObj.getInstance().getByLoginIndex("1007"));
            addEventListener(Event.ENTER_FRAME, this.initGameModule);
            return;
        }// end function

        private function initGameModule(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.initGameModule);
            var _loc_2:* = new Loader();
            var _loc_3:* = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loc_3.allowCodeImport = true;
            _loc_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInitGameModuleOk);
            _loc_2.loadBytes(this.gameModuleBa, _loc_3);
            return;
        }// end function

        private function onInitGameModuleOk(event:Event) : void
        {
            this.gameModuleBa = null;
            var _loc_2:* = event.currentTarget as LoaderInfo;
            _loc_2.removeEventListener(Event.COMPLETE, this.onInitGameModuleOk);
            _loc_2.loader.unloadAndStop(false);
            this.startGameModule();
            return;
        }// end function

        private function startGameModule() : void
        {
            Log.log("index === 进入主程序");
            try
            {
                BasicGlobal.gameModule.indexGame();
            }
            catch (e:Error)
            {
                Log.log("index === error: " + e + "\n" + e.getStackTrace());
                showText(LanguageCfgObj.getInstance().getByLoginIndex("1008") + e);
            }
            this.dispose();
            this.onStageResize();
            return;
        }// end function

        private function test() : void
        {
            return;
        }// end function

        private function showProgress(param1:String, param2:Function = null) : Function
        {
            var msg:* = param1;
            var condition:* = param2;
            if (condition == null)
            {
                this.loadingPanel.setValueAll(0, 0);
                this.loadingPanel.setBgMsg(msg);
            }
            return function (event:ProgressEvent, param2:VResLoadObj) : void
            {
                if (condition == null || condition())
                {
                    if (loadingPanel.getBgMsg() != msg)
                    {
                        loadingPanel.setBgMsg(msg);
                    }
                    if (param2.groupInfo)
                    {
                        loadingPanel.setValueAll(param2.groupInfo.loadedSize, param2.groupInfo.totalSize);
                    }
                    else
                    {
                        loadingPanel.setValueAll(event.bytesLoaded, event.bytesTotal);
                    }
                }
                return;
            }// end function
            ;
        }// end function

        private function getMD5ServerKey() : String
        {
            return MD5.hash(Params.username + Params.time + Params.serverOpenKey);
        }// end function

        private function chechPfMd5() : Boolean
        {
            var _loc_1:* = Params.pfMD5Key;
            var _loc_2:* = MD5.hash(Params.username + Params.serverid + Params.isadult + Params.time + Params.pfOpenKey);
            Log.log("验证--", Params.username, Params.serverid, Params.isadult, Params.time, Params.pfOpenKey, Params.pfMD5Key, _loc_2);
            return _loc_1 == _loc_2;
        }// end function

        private function showText(param1:String = "") : void
        {
            var _loc_2:* = null;
            if (!this.text)
            {
                this.text = new TextField();
                this.text.width = 500;
                this.text.height = 100;
                this.text.wordWrap = true;
                this.text.multiline = true;
                _loc_2 = new TextFormat(Params.FONT1, 14, 16777215);
                _loc_2.align = TextFieldAutoSize.CENTER;
                _loc_2.color = 12303291;
                _loc_2.letterSpacing = 3;
                this.text.defaultTextFormat = _loc_2;
            }
            this.text.htmlText = param1;
            if (!this.text.parent)
            {
                this.layoutText();
                addChild(this.text);
            }
            return;
        }// end function

        public function hideTxt() : void
        {
            if (this.text && this.text.parent)
            {
                this.text.parent.removeChild(this.text);
                this.text = null;
            }
            JSCaller.GameReady(false);
            return;
        }// end function

        private function layoutText() : void
        {
            layoutMC(this.text);
            return;
        }// end function

        private function onStageResize(event:Event = null) : void
        {
            setWH(stage.stageWidth, stage.stageHeight);
            if (this.text && this.text.parent)
            {
                this.layoutText();
            }
            if (this.loadingPanel)
            {
                layoutMC(this.loadingPanel);
            }
            if (BasicGlobal.sceneManager)
            {
                BasicGlobal.sceneManager.resize();
            }
            if (BasicGlobal.gameModule)
            {
                BasicGlobal.gameModule.resize();
            }
            return;
        }// end function

        private function onMouseClickStage(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as TextField;
            if (!(_loc_2 && _loc_2.type == TextFieldType.INPUT))
            {
                IME.enabled = false;
            }
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            if (event.ctrlKey && event.shiftKey)
            {
                if (event.charCode == KeyCode.L || event.charCode == KeyCode.L + 32)
                {
                    _loc_2 = new FileReference();
                    _loc_3 = new ByteArray();
                    _loc_3.writeMultiByte(Log.strAll, "utf-8");
                    _loc_4 = new Date();
                    _loc_5 = _loc_4.getHours();
                    _loc_6 = _loc_4.getMinutes();
                    _loc_7 = _loc_4.getSeconds();
                    _loc_8 = _loc_5 + "点" + _loc_6 + "分" + _loc_7 + "秒";
                    _loc_2.save(Log.strAll, BasicGlobal.openid + "Log" + _loc_8 + ".txt");
                }
            }
            return;
        }// end function

    }
}
