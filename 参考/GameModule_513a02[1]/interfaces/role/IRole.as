package interfaces.role
{
    import com.game.buff.message.*;
    import com.model.vo.*;
    import flash.display.*;
    import interfaces.role.*;

    public interface IRole extends ISimpleRole
    {

        public function IRole();

        function get stopWhenEffect() : Boolean;

        function set stopWhenEffect(param1:Boolean) : void;

        function get stopWhenRelease() : Boolean;

        function set stopWhenRelease(param1:Boolean) : void;

        function isFriend() : Boolean;

        function isEnemy() : Boolean;

        function isTeamMember(param1:Boolean = true) : Boolean;

        function get fatherActType() : String;

        function alive() : Boolean;

        function revive() : void;

        function isRidingHorse() : Boolean;

        function attack() : void;

        function canAtk(param1:IRole) : Boolean;

        function face2(param1:int, param2:int) : int;

        function hideBloodStripe() : void;

        function showBloodStripe() : void;

        function set isZonesMorph(param1:Boolean) : void;

        function get isZonesMorph() : Boolean;

        function set isInSkillShunyi(param1:Boolean) : void;

        function get isInSkillShunyi() : Boolean;

        function distanceSQ(param1:IRole) : uint;

        function setOldItemCfg(param1:int, param2:int) : void;

        function attacked(param1:Boolean, param2:int = 0, param3:int = 0, param4:uint = 1, param5:int = 1, param6:int = 60, param7:int = 1) : void;

        function dead() : void;

        function kickFly(param1:IRole, param2:uint, param3:Boolean = true) : void;

        function addBuffView(param1:BuffInfo) : void;

        function removeBuffView(param1:BuffInfo) : void;

        function getBuffInfoBack(param1:ResBuffInfoMessage) : void;

        function hasBuff(param1:uint) : Boolean;

        function set alwaysShowBloodStripe(param1:Boolean) : void;

        function addCircle(param1:DisplayObject) : void;

        function get cutePet() : CutePetInfo;

        function get magicBookInfo() : MagicBookInfo;

        function resetCutePet() : void;

        function resetMagicBook() : void;

        function showZonesIntegral(param1:int) : void;

        function updateTitleImg() : void;

        function updateSuitEffect() : void;

        function showComboEffect() : void;

    }
}
