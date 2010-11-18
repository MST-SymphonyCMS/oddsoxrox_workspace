<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcelogo extends Datasource{
		
		public $dsParamROOTELEMENT = 'logo';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		public $dsParamFILTERS = array(
				'1' => 'odd-sox-rox',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'logo',
				'alt-tag'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Logo',
					 'author' => array(
							'name' => 'John Porter',
							'website' => 'http://develop.oddsoxrox.co.uk',
							'email' => 'john.porter@designermonkey.co.uk'),
					 'version' => '1.0',
					 'release-date' => '2010-11-17T20:44:10+00:00');	
		}
		
		public function getSource(){
			return '1';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}			
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}	

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

