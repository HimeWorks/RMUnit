=begin
#===============================================================================
 Title: RMUnit
 Authors: Tsukihime
 Date: Aug 1, 2013
--------------------------------------------------------------------------------
 ** Change log
 Aug 1, 2013
   - Initial release
--------------------------------------------------------------------------------   
 ** Terms of Use
 * Free to use in commercial/non-commercial projects
 * No real support. The script is provided as-is
 * Will do bug fixes, but no compatibility patches
 * Features may be requested but no guarantees, especially if it is non-trivial
 * Credits to Tsukihime in your project
 * Preserve this header
--------------------------------------------------------------------------------
 ** Description
 
 This is a unit test framework provided for RPG Maker VX Ace. It is built
 on top of Test::Unit and comes with a set of test suites specific for the
 default engine that comes with RM.
 
--------------------------------------------------------------------------------
 ** Required
 
 RMUnit framework. You can get them at
 http://himeworks.wordpress.com/2013/07/31/rmunit-test-framework/
 
--------------------------------------------------------------------------------
 ** Installation
 
 Place this script below Materials and above Main.
 The RMUnit framework should be placed in the System folder of your project.

--------------------------------------------------------------------------------
 ** Usage 
 
 For developers.
 http://ruby-doc.org/stdlib-1.8.7/libdoc/test/unit/rdoc/Test/Unit.html
 
#===============================================================================
=end
$imported = {} if $imported.nil?
$imported["TH_RMUnit"] = true
#===============================================================================
# ** Configuration
#===============================================================================
module RMUnit    
  # Test suites to run.
  TestSuites = [
    :Test_GameActor,
  ]
    
  def self.run
    TestSuites.each do |suite|
      testClass =  Object.const_get(suite)
      Test::Unit::UI::Console::TestRunner.run(testClass)
    end
  end
end
#===============================================================================
# ** Rest of script
#===============================================================================
#-------------------------------------------------------------------------------
$LOAD_PATH << "System/RMUnit" unless $LOAD_PATH.include?("System/RMUnit")
require 'test-unit'
require 'test/unit/ui/console/testrunner'
#-------------------------------------------------------------------------------
module DataManager
  
  class << self
    alias :th_rmunit_init :init
  end
  
  def self.init
    th_rmunit_init
    RMUnit.run
  end
end

#-------------------------------------------------------------------------------
# Sample test class
#-------------------------------------------------------------------------------
class Test_GameActor < Test::Unit::TestCase
  
  #-----------------------------------------------------------------------------
  # Initialize some data for the test cases
  #-----------------------------------------------------------------------------
  def setup
    @actor_id = 1
    @actor = Game_Actor.new(@actor_id)
  end
  
  #-----------------------------------------------------------------------------
  # Clean up after the tests are complete
  #-----------------------------------------------------------------------------
  def teardown
    # if necessary
  end
  
  #-----------------------------------------------------------------------------
  # Simple test: try to set up an actor
  #-----------------------------------------------------------------------------
  def test_setup
    @actor.setup(@actor_id)
  end
  
  #-----------------------------------------------------------------------------
  # Simple negative test. This should fail.
  #-----------------------------------------------------------------------------
  def test_fail_setup
    @actor.setup
  end
end