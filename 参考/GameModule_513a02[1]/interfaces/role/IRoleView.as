package interfaces.role
{
    import com.f1.interfaces.*;
    import com.f1.ui.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public interface IRoleView extends IBaseSprite
    {

        public function IRoleView();

        function get px() : uint;

        function get py() : uint;

        function get isShow() : Boolean;

        function set isShow(param1:Boolean) : void;

        function get distanceToPlayer() : uint;

        function set distanceToPlayer(param1:uint) : void;

        function checkStrengthAll() : void;

        function updateWing() : void;

        function hide() : void;

        function show() : void;

        function isLoadingRes() : Boolean;

        function updateAct() : Boolean;

        function isEffect() : Boolean;

        function enterFrame(event:Event = null) : void;

        function set auto(param1:Boolean) : void;

        function loadRoleRes() : void;

        function set info(param1:RoleInfo) : void;

        function get info() : RoleInfo;

        function set scale(param1:Number) : void;

        function get scale() : Number;

        function select() : void;

        function unSelect() : void;

        function showTopCue(param1, param2:uint = 16777215, param3:uint = 16, param4:int = 0, param5:int = 0, param6:uint = 2, param7:Number = 1, param8:uint = 100, param9:Number = 0.5, param10:Boolean = false, param11:int = 0, param12:int = 0, param13:int = 1, param14:int = 22, param15:int = 1) : void;

        function setAct(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Boolean = false) : Boolean;

        function set direct(param1:int) : void;

        function get direct() : int;

        function speak(param1:String) : void;

        function richSpeak(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null, param5:int = 0) : void;

        function stopSpeak() : void;

        function isStand() : Boolean;

        function isSpeaking() : Boolean;

        function updatePosition() : void;

        function get high() : uint;

        function get wild() : uint;

        function get sex() : uint;

        function get actType() : String;

        function hideShadow() : void;

        function get currentActReleaseTime() : Number;

        function get currentActEffectTime() : Number;

        function get currentActFlyTime() : Number;

        function set currentActFlyTime(param1:Number) : void;

        function get bmp() : BMPView;

        function addRes(param1, param2:Number = 0.5, param3:uint = 1, param4:uint = 0) : DisplayObject;

        function doAddRes(param1:DisplayObject, param2:Number, param3:uint, param4:uint = 0) : void;

        function shine(param1:uint = 16773120) : void;

        function unShine() : void;

        function play() : void;

        function stop() : void;

        function replay() : void;

        function updateHorse() : void;

        function updateWeapon() : void;

        function updateWeaponOther() : void;

        function isUser() : Boolean;

        function isPlayer() : Boolean;

        function isNPC() : Boolean;

        function isMonster() : Boolean;

        function isSummonPet() : Boolean;

        function isClientMonster() : Boolean;

    }
}
