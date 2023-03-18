CREATE TABLE Users
(
    UserID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PasswordHash VARBINARY(MAX) NOT NULL,
    PasswordSalt VARBINARY(MAX) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    UpdatedAt DATETIME2 NULL
)

CREATE TABLE Assets
(
    AssetID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    AssetName VARCHAR(50) NOT NULL,
    AssetDescription VARCHAR(255),
    Location VARCHAR(50),
    Manufacturer VARCHAR(50),
    ModelNumber VARCHAR(50),
    SerialNumber VARCHAR(50),
    InstallationDate DATE,
    LastMaintenanceDate DATE,
    PurchaseDate DATE,
    PurchasePrice DECIMAL(10,2),
    Status VARCHAR(50),
    Category VARCHAR(50),
)

CREATE TABLE Priorities
(
    PriorityID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CreatedDate DATETIME NOT NULL,
    CreatedBy UNIQUEIDENTIFIER FOREIGN KEY (CreatedBy) REFERENCES Users(userID),
    Description VARCHAR(50) NOT NULL,
)

CREATE TABLE WorkOrders
(
    WorkOrderID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CreatedDate DATETIME NOT NULL,
    CreatedBy UNIQUEIDENTIFIER FOREIGN KEY (CreatedBy) REFERENCES Users(userID),
    AssetID UNIQUEIDENTIFIER FOREIGN KEY (AssetID) REFERENCES Assets(assetID),
    Description VARCHAR(1000) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Priority UNIQUEIDENTIFIER FOREIGN KEY (Priority) REFERENCES Priorities(PriorityID) NOT NULL ,
    Notes VARCHAR(max) NULL,
    EstimatedCompletionDate DATE NULL,
    ActualCompletionDate DATE NULL
)

CREATE TABLE WorkOrderRequests
(
    WorkOrderID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CreatedDate DATETIME NOT NULL,
    CreatedBy UNIQUEIDENTIFIER FOREIGN KEY (CreatedBy) REFERENCES Users(UserID) NOT NULL,
    ApprovedBy UNIQUEIDENTIFIER FOREIGN KEY (ApprovedBy) REFERENCES Users(UserID) NULL,
    DeniedBy UNIQUEIDENTIFIER FOREIGN KEY (DeniedBy) REFERENCES Users(UserID) NULL,
    AssetID UNIQUEIDENTIFIER FOREIGN KEY (AssetID) REFERENCES Assets(AssetID) NOT NULL,
    Description VARCHAR(1000) NOT NULL,
    Status VARCHAR(50) NOT NULL DEFAULT 'Pending Approval',
    Priority UNIQUEIDENTIFIER FOREIGN KEY (Priority) REFERENCES Priorities(PriorityID) NOT NULL ,
    Notes VARCHAR(max) NULL,
)

CREATE TABLE Tasks
(
    TaskID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CreatedDate DATETIME NOT NULL,
    CreatedBy UNIQUEIDENTIFIER FOREIGN KEY (CreatedBy) REFERENCES Users(userID),
    AssetID UNIQUEIDENTIFIER FOREIGN KEY (AssetID) REFERENCES Assets(assetID),
    Description VARCHAR(1000) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Priority UNIQUEIDENTIFIER FOREIGN KEY (Priority) REFERENCES Priorities(PriorityID) NOT NULL ,
    Notes VARCHAR(max) NULL,
    LastCompletionDate DATE NULL
)

CREATE TABLE Images
(
    AssetID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ImageName nvarchar(100),
    Description nvarchar(max),
    FilePath nvarchar(max)
)

CREATE TABLE Documents
(
    DocumentID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FileName nvarchar(100),
    Description nvarchar(max),
    FilePath nvarchar(max)
)

CREATE TABLE Schedules
(
    ScheduleID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Type nvarchar(100) NOT NULL,
    Data DATETIME NOT NULL,

)

CREATE TABLE Tasks_Documents
(
    Tasks_DocumentsID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TaskID UNIQUEIDENTIFIER FOREIGN KEY (TaskID) REFERENCES Tanks(TaskID),
    DocumentID UNIQUEIDENTIFIER FOREIGN KEY (DocumentID) REFERENCES Documents(DocumentID)
)

CREATE TABLE Tasks_Images
(
    Tasks_ImagesID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TaskID UNIQUEIDENTIFIER FOREIGN KEY (TaskID) REFERENCES Tanks(TaskID),
    ImageID UNIQUEIDENTIFIER FOREIGN KEY (ImageID) REFERENCES Images(ImageID)
)

CREATE TABLE WorkOrders_Documents
(
    WorkOrders_DocumentsID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    WorkOrderID UNIQUEIDENTIFIER FOREIGN KEY (WorkOrderID) REFERENCES WorkOrders(WorkOrderID),
    DocumentID UNIQUEIDENTIFIER FOREIGN KEY (DocumentID) REFERENCES Documents(DocumentID)
)

CREATE TABLE WorkOrders_Images
(
    WorkOrders_ImagesID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    WorkOrderID UNIQUEIDENTIFIER FOREIGN KEY (WorkOrderID) REFERENCES WorkOrders(WorkOrderID),
    ImageID UNIQUEIDENTIFIER FOREIGN KEY (ImageID) REFERENCES Images(ImageID)
)