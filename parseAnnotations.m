function [filenames, labels] = parseAnnotations(annotationFolder)
    % Parse .xml annotations to extract filenames and labels
    % Inputs:
    % - annotationFolder: Path to the folder containing .xml files
    % Outputs:
    % - filenames: Cell array of image filenames
    % - labels: Cell array of corresponding labels

    % Get all .xml files in the folder
    xmlFiles = dir(fullfile(annotationFolder, '*.xml'));
    filenames = {};
    labels = {};
    
    
    for i = 1:length(xmlFiles)
        xmlFile = fullfile(annotationFolder, xmlFiles(i).name);
        xmlData = xmlread(xmlFile);
        
        filenameNode = xmlData.getElementsByTagName('filename').item(0);
        filenames{i} = char(filenameNode.getTextContent());
        
        labelNode = xmlData.getElementsByTagName('name').item(0);
        labels{i} = char(labelNode.getTextContent());
    end
end
