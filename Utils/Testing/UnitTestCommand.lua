UnitTestCommand = class( Turbine.ShellCommand );

function UnitTestCommand:Execute( command, arguments )
	local runner = ShellTestRunner();
	runner:SetVerbose( true );

	if (arguments == nil or arguments == "") then
		runner:RunAllUnitTests();
	else
		runner:RunUnitTestByName( arguments );
	end
end

function UnitTestCommand:GetHelp()
	return "Executes a unit test.";
end

function UnitTestCommand:GetShortHelp()
	return "Executes a unit test.";
end
