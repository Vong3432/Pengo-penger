import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penger/bloc/dpo-columns/dpo_columns_bloc.dart';
import 'package:penger/bloc/dpo-tables/dpo_tables_bloc.dart';
import 'package:penger/config/color.dart';
import 'package:penger/const/space_const.dart';
import 'package:penger/helpers/theme/custom_font.dart';
import 'package:penger/models/condition_model.dart';
import 'package:penger/models/dpo_column_model.dart';
import 'package:penger/models/dpo_table_model.dart';
import 'package:penger/ui/priority-option/widgets/priority_dropdown_item.dart';
import 'package:penger/ui/priority-option/widgets/priority_field_box.dart';
import 'package:penger/ui/widgets/api/error.dart';
import 'package:penger/ui/widgets/input/custom_textfield.dart';

class PriorityField extends StatefulWidget {
  const PriorityField({
    Key? key,
    required this.onTableFieldChanged,
    required this.onDpoColumnChanged,
    required this.onConditionChanged,
    required this.onValueChanged,
    this.defaultCondition,
    this.defaultColumn,
    this.defaultTable,
    this.defaultValue,
  }) : super(key: key);
  final ValueSetter<DpoTable> onTableFieldChanged;
  final ValueSetter<DpoColumn> onDpoColumnChanged;
  final ValueSetter<Condition> onConditionChanged;
  final ValueSetter<String> onValueChanged;
  final DpoTable? defaultTable;
  final DpoColumn? defaultColumn;
  final Condition? defaultCondition;
  final String? defaultValue;

  @override
  _PriorityFieldState createState() => _PriorityFieldState();
}

class _PriorityFieldState extends State<PriorityField> {
  Condition? _selectedCondition;
  DpoTable? _selectedTable;
  DpoColumn? _selectedColumn;

  final DpoTablesBloc _tableBloc = DpoTablesBloc();
  final DpoColumnsBloc _columnBloc = DpoColumnsBloc();

  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      if (widget.defaultColumn != null) {
        _selectedColumn = widget.defaultColumn;
      }
      if (widget.defaultTable != null) {
        _selectedTable = widget.defaultTable;
        _columnBloc.add(FetchColumns(_selectedTable!));
      }
      if (widget.defaultCondition != null) {
        _selectedCondition = widget.defaultCondition;
      }
    });

    _controller = TextEditingController(text: widget.defaultValue ?? "");
    _loadTables();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DpoTablesBloc>(
          create: (context) => _tableBloc,
        ),
        BlocProvider<DpoColumnsBloc>(
          create: (context) => _columnBloc,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Defined priority",
            style: PengoStyle.caption(context),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT / 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTablesField(),
              const SizedBox(
                width: SECTION_GAP_HEIGHT / 2,
              ),
              _buildColumnsField(),
              const SizedBox(
                width: SECTION_GAP_HEIGHT / 2,
              ),
              _buildConditionsField(),
              const SizedBox(
                width: SECTION_GAP_HEIGHT / 2,
              ),
              _buildValueField(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _buildPriorityOptionSentences(context),
          ),
        ],
      ),
    );
  }

  Row _buildPriorityOptionSentences(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        ),
        const SizedBox(
          width: SECTION_GAP_HEIGHT / 2,
        ),
        Text(
          "Preserved for ${_selectedTable?.tableName ?? ""} ${_selectedTable == null ? "" : "'s"} ${_selectedColumn?.column ?? ""} ${_selectedCondition?.formattedValue ?? ""} ${_controller.text} ",
          style: PengoStyle.text(context),
        ),
      ],
    );
  }

  Widget _buildTablesField() {
    return Expanded(
      flex: 2,
      child: BlocBuilder<DpoTablesBloc, DpoTablesState>(
        builder: (BuildContext context, DpoTablesState state) {
          switch (state.status) {
            case DpoTablesStatus.success:
              return PriorityFieldBox<DpoTable>(
                items: state.dpoTables,
                itemBuilder: (DpoTable table) {
                  return PriorityOptionDropdownItem(value: table.tableName);
                },
                currValue: _selectedTable?.tableName,
                onItemSelected: _onTableChanged,
              );
            case DpoTablesStatus.failure:
              return const ErrorResultWidget();
            default:
              return emptyFieldBox;
          }
        },
      ),
    );
  }

  final Widget emptyFieldBox = PriorityFieldBox(
    items: [],
    itemBuilder: (_) {
      return const PriorityOptionDropdownItem(
        value: "",
      );
    },
  );

  Widget _buildColumnsField() {
    return Expanded(
      flex: 2,
      child: BlocBuilder<DpoColumnsBloc, DpoColumnsState>(
        builder: (BuildContext context, DpoColumnsState state) {
          switch (state.status) {
            case DpoColumnsStatus.success:
              return PriorityFieldBox<DpoColumn>(
                items: state.dpoColumns ?? [],
                itemBuilder: (DpoColumn columnItem) {
                  return PriorityOptionDropdownItem(value: columnItem.column);
                },
                currValue: _selectedColumn?.column,
                onItemSelected: _onColumnChanged,
              );
            case DpoColumnsStatus.failure:
              return const ErrorResultWidget();
            default:
              return emptyFieldBox;
          }
        },
      ),
    );
  }

  Widget _buildConditionsField() {
    return Expanded(
      flex: 2,
      child: PriorityFieldBox<Condition>(
        items: conditionList,
        itemBuilder: (Condition condition) {
          return PriorityOptionDropdownItem(value: condition.symbol);
        },
        currValue: _selectedCondition?.symbol,
        onItemSelected: (Condition condition) {
          setState(() {
            _selectedCondition = condition;
          });
          widget.onConditionChanged(condition);
        },
      ),
    );
  }

  Widget _buildValueField() {
    return Container(
      width: 72,
      child: CustomTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        hintText: "1",
        inputType: TextInputType.number,
        controller: _controller,
        onChanged: (String val) => widget.onValueChanged(val),
      ),
    );
  }

  void _loadTables() {
    _tableBloc.add(FetchDpoTables());
  }

  void _onTableChanged(DpoTable table) {
    setState(() {
      _selectedTable = table;
      _selectedColumn = null;
    });
    _columnBloc.add(FetchColumns(table));
    widget.onTableFieldChanged(table);
  }

  void _onColumnChanged(DpoColumn column) {
    setState(() {
      _selectedColumn = column;
    });
    widget.onDpoColumnChanged(column);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
